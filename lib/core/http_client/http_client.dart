import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_proj/core/errors/exceptions/exceptions.dart';

import '../../config/service_locator/service_locator.dart';
import '../autoroute/autoroute_cubit.dart';

const String _loginCredintialKey = "loginCredential";

enum ApiCallMethod { get, post, put, delete }

/// this will return map or list after json decode
/// if there is an error in authentication or Internet or error messsage
/// in api response or any other error throws exception [ServerException]
class HttpCalls {
  final FlutterSecureStorage _flutterSecureStorage;
  final Logger _logger = Logger("HttpCalls");
  final Map<String, String> _cookies = {};

  HttpCalls({
    required SharedPreferences sharedPreferences,
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  /// this will return map or list after json decode
  /// if there is an error in authentication or Internet or error messsage
  /// in api response or any other error throws exception [ServerException]
  Future<dynamic> call(
      {required String url,
      required ApiCallMethod method,
      dynamic body,
      bool guarded = false}) async {
    try {
      _logger.info("accessing $url");

      Map<String, String>? headers;

      if (guarded) {
        headers = {
          "Authorization":
              "Bearer ${await getAccessTokenFromPersistanceStorage()}"
        };
      }

      final request = http.Request(describeEnum(method), Uri.parse(url));

      request.body = json.encode(body);
      if (headers != null) request.headers.addAll(headers);

      request.headers.addAll(
          {'Content-Type': 'application/json', "Accept": "application/json"});

      // get the previous cookies and send them in request
      final cookies = await _generateCookieHeader();
      if (cookies.isNotEmpty) request.headers['cookie'] = cookies;

      http.StreamedResponse streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      _updateCookie(response);

      _logger.info("[${response.statusCode}] [$url]");
      if (response.body.isEmpty) return {};

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        if (response.statusCode == 422) {
          //TODO : handle your error here
          const error = "Something went wrong";
          throw ServerException(message: error);
        }

        if (response.statusCode == 401) {
          sl<AutorouteCubit>().routingEvent((context) {
            context.router.popUntilRoot();
            // TODO: handle your logout logic here
          });

          const message = "Not Authorized";
          throw ServerException(message: message);
        }

        if (response.statusCode == 404) {
          throw ServerException(
              message: "url not found", statusCode: response.statusCode);
        }
        if (response.statusCode == 413) {
          throw ServerException(
              message: "File Size to too large",
              statusCode: response.statusCode);
        }
        //TODO: add custom message here
        throw ServerException(
            description: "File Size to too large",
            message: "File Size to too large",
            statusCode: response.statusCode);
      }
    } catch (e) {
      if (e is SocketException) {
        throw ServerException(
          description: "Could not reach server",
          message: "Internet Error",
        );
      } else {
        rethrow;
      }
    }
  }

  Future<String> getAccessTokenFromPersistanceStorage() async {
    final token = await _flutterSecureStorage.read(key: _loginCredintialKey);

    return (token != null) ? token : throw Exception("Token is not present");
  }

  /// this will update cookie in secure storage as well as in the [cookies]
  void _updateCookie(http.Response response) async {
    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      await _flutterSecureStorage.write(key: 'set-cookie', value: allSetCookie);
      updateCookieFromString(allSetCookie);
    }
  }

  void updateCookieFromString(String allSetCookie) {
    var setCookies = allSetCookie.split(',');

    for (var setCookie in setCookies) {
      var cookies = setCookie.split(';');

      for (var cookie in cookies) {
        _setCookie(cookie);
      }
    }
  }

  void _setCookie(String rawCookie) {
    if (rawCookie.isEmpty) {
      int idx = rawCookie.indexOf("=");
      if (idx >= 0) {
        var key = rawCookie.substring(0, idx).trim();
        var value = rawCookie.substring(idx + 1).trim();
        if (key == 'path' ||
            key == 'expires' ||
            key == 'domain' ||
            key == 'SameSite') return;
        _cookies[key] = value;
      }
    }
  }

  Future<String> _generateCookieHeader() async {
    final localCookie = await _flutterSecureStorage.read(key: 'set-cookie');
    if (localCookie != null) updateCookieFromString(localCookie);

    String cookie = "";
    for (var key in _cookies.keys) {
      if (cookie.isEmpty) cookie += ";";
      cookie += "$key=${_cookies[key]!}";
    }
    return cookie;
  }

  Future<Map<String, File>> compressFiles(Map<String, File> files) async {
    Map<String, File> listOfCompreesses = {};
    final listOfKeys = files.keys.toList();
    for (int i = 0; i < files.keys.length; i++) {
      if (lookupMimeType(files[listOfKeys[i]]!.path.split('/').last)
              ?.contains("image") ??
          false) {
        final File? compressedFile =
            await FlutterImageCompress.compressAndGetFile(
          files[listOfKeys[i]]!.absolute.path,
          "what.jpg",
          minHeight: 500,
          minWidth: 400,
          quality: 50,
        );

        listOfCompreesses[listOfKeys[i]] =
            compressedFile ?? files[listOfKeys[i]]!;
      } else {
        listOfCompreesses[listOfKeys[i]] = files[listOfKeys[i]]!;
      }
    }

    return listOfCompreesses;
  }

  Future multipart({
    required String url,
    Map<String, File>? filesField,
    Map<String, String>? fields,
  }) async {
    try {
      var req = http.MultipartRequest('POST', Uri.parse(url));

      if (filesField != null && filesField.isNotEmpty) {
        final afterCompreess = await compressFiles(filesField);

        final files = afterCompreess.entries.map(
          (element) => http.MultipartFile(
              element.key,
              element.value.readAsBytes().asStream(),
              element.value.lengthSync(),
              filename: element.value.path.split('/').last),
        );
        req.files.addAll(files);
      }
      if (fields != null && fields.isNotEmpty) req.fields.addAll(fields);
      req.headers.addAll({
        'Accept': 'application/json',
        "Authorization":
            "Bearer ${await getAccessTokenFromPersistanceStorage()}"
      });

      final response = await http.Response.fromStream(await req.send());
      _logger.info("access complete ${response.statusCode} $url [post] ");

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        if (response.statusCode == 422) {
          //TODO : handle your error here
          final error = json.decode(response.body);
          final message = error["errors"] != null
              ? (error["errors"] as Map<String, dynamic>)
                  .entries
                  .map((e) => e.value)
                  .toList()
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '\n')
              : "";

          throw ServerException(message: error["message"] + '\n$message');
        }
        if (response.statusCode == 413) {
          // TODO: handle your error here
          throw ServerException(message: 'Your file exceeds the upload limit.');
        }

        if (response.statusCode == 401) {
          //TODO handle your error here
          String message;
          try {
            message = json.decode(response.body)["message"];
          } catch (e) {
            message = "Not Authorized";
          }
          throw ServerException(message: message);
        }
        if (response.statusCode == 404) {
          throw ServerException(
              message: "url not found", statusCode: response.statusCode);
        }

        final jsonObject = json.decode(response.body);

        throw ServerException(
            description:
                jsonObject["error_description"] ?? jsonObject["message"] ?? "",
            message: jsonObject["error"] ?? "Unknown Error",
            statusCode: response.statusCode);
      }
    } catch (e) {
      if (e is SocketException) {
        throw ServerException(
          description: "Could not reach server",
          message: "Internet Error",
        );
      } else {
        rethrow;
      }
    }
  }
}

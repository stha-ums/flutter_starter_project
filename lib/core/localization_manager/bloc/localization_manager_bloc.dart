import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_manager_event.dart';
part 'localization_manager_state.dart';

class LocalizationManagerBloc
    extends Bloc<LocalizationManagerEvent, LocalizationManagerState> {
  final SharedPreferences sharedPreferences;
  final _logger = Logger('LocalizationManagerBloc');

  LocalizationManagerBloc({required this.sharedPreferences})
      : super(const LocalizationManagerState()) {
    on<InitializeLocale>((event, emit) {
      _logger.info("InitializeLocale");

      emit(LocalizationManagerState(
          locale: getSavedThemeMode(), initialized: true));
    });
    on<ChangeLocale>((event, emit) async {
      emit(LocalizationManagerState(locale: event.locale, initialized: true));
      _logger.info("ChangeLocale");
      await setLocale(event.locale);
    });
  }

  Locale? getSavedThemeMode() {
    try {
      final locale = sharedPreferences.getString("locale");
      if (locale != null) {
        return Locale(locale);
      }
      return null;
    } catch (e) {
      _logger.warning("Could not get saved locale");
      return null;
    }
  }

  Future<bool> setLocale(Locale locale) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString("locale", locale.languageCode);
  }
}

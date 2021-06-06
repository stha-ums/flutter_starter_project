import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:starter/core/external/connectivity/check_connectivity.dart';
import 'package:starter/core/external/connectivity/data_connection_checker.dart';
import 'package:starter/features/localization_manager/bloc/localization_manager_bloc.dart';
import 'package:starter/features/theme_manager/bloc/theme_manager_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  //! Features
  _initFeatures();

  //! Core
  _initCore();

  //! External
  await _intExternal();
}

void _initFeatures() {
  // Bloc
  _initBlocs();

  // usecases
  _initUseCases();

  //repositories
  _initRepositories();

  // datasources local
  _localRemoteLocalDataSource();

  //datasource remote
  _initRemoteDataSources();
}

void _initBlocs() {
  _initThemeManager();
  _initLocaleManager();
}

void _initThemeManager() {
  sl.registerFactory(() => ThemeManagerBloc(sharedPreferences: sl()));
}

void _initLocaleManager() {
  sl.registerFactory(() => LocalizationManagerBloc(sharedPreferences: sl()));
}

void _initUseCases() {}

void _initRepositories() {}

void _initRemoteDataSources() {}

void _localRemoteLocalDataSource() {}

void _initCore() {
  // netWorkInfo
  sl.registerLazySingleton<NetWorkInfo>(
      () => NetworkInfoImpl(dataConnectionChecker: sl()));
}

Future<void> _intExternal() async {
  //shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // http client
  sl.registerLazySingleton(() => http.Client());

  // dataConnection checker
  sl.registerLazySingleton(() => DataConnectionChecker());
}

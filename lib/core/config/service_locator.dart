import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/features/localization_manager/bloc/localization_manager_bloc.dart';
import 'package:starter/features/theme_manager/bloc/theme_manager_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  _initThemeManager();
  _initLocaleManager();
  await _initExternalResources();
}

void _initThemeManager() {
  sl.registerFactory(() => ThemeManagerBloc(sharedPreferences: sl()));
}

void _initLocaleManager() {
  sl.registerFactory(() => LocalizationManagerBloc(sharedPreferences: sl()));
}

Future<void> _initExternalResources() async {
  //shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

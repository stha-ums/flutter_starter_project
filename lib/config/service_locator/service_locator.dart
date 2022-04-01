import 'package:get_it/get_it.dart';
import 'package:starter/core/localization_manager/bloc/localization_manager_bloc.dart';
import 'package:starter/core/theme/bloc/theme_manager_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await _registerExternal();
  _registerCore();
}

void _registerCore() {
  sl.registerFactory(() => ThemeManagerBloc(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationManagerBloc(sharedPreferences: sl()));
}

Future<void> _registerExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory<SharedPreferences>(() => sharedPreferences);
}

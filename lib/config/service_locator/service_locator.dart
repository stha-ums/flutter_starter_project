import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_proj/core/localization_manager/bloc/localization_manager_bloc.dart';
import 'package:starter_proj/core/theme/bloc/theme_manager_bloc.dart';

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

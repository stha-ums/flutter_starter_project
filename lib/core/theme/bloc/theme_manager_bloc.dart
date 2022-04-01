import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_manager_event.dart';

class ThemeManagerBloc extends Bloc<ThemeManagerEvent, ThemeMode> {
  final SharedPreferences _sharedPreferences;

  final Logger _logger = Logger("ThemeManagerBloc");

  ThemeManagerBloc({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(ThemeMode.system) {
    on<ChangeThemeMode>(_changeThemeMode);
    on<Init>(_initializeThemeData);
  }

  _changeThemeMode(ChangeThemeMode event, Emitter<ThemeMode?> emit) async {
    await setThemeMode(event.themeMode);
    emit(event.themeMode);
  }

  _initializeThemeData(Init event, Emitter<ThemeMode?> emit) {
    emit(getSavedThemeMode());
  }

  ThemeMode getSavedThemeMode() {
    try {
      final themeMode = _sharedPreferences.getInt("themeMode");
      return themeMode == null ? ThemeMode.system : ThemeMode.values[themeMode];
    } catch (e) {
      _logger.warning("Could not get saved theme mode");
      return ThemeMode.system;
    }
  }

  Future<bool> setThemeMode(ThemeMode state) async {
    return _sharedPreferences.setInt("themeMode", state.index);
  }
}

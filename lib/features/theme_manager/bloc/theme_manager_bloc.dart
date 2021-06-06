import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_manager_event.dart';

class ThemeManagerBloc extends Bloc<ThemeManagerEvent, ThemeMode?> {
  final SharedPreferences sharedPreferences;

  final Logger _logger = Logger("ThemeManagerBloc");

  ThemeManagerBloc({required this.sharedPreferences}) : super(null);

  @override
  Stream<ThemeMode> mapEventToState(
    ThemeManagerEvent event,
  ) async* {
    if (event is Init) {
      _logger.info("Initializing Theme manager");
      yield getSavedThemeMode();
    }

    if (event is ChangeThemeMode) {
      _logger.info("Theme mood changed to ${event.themeMode}");

      yield event.themeMode;
      await setThemeMode(event.themeMode);
    }
  }

  ThemeMode getSavedThemeMode() {
    try {
      final themeMode = sharedPreferences.getInt("themeMode");
      if (themeMode != null) {
        return ThemeMode.values[themeMode];
      } else
        return ThemeMode.system;
    } catch (e) {
      _logger.warning("Could not get saved theme mode");
      return ThemeMode.system;
    }
  }

  Future<bool> setThemeMode(ThemeMode state) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt("themeMode", state.index);
  }
}

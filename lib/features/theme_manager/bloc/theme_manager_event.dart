part of 'theme_manager_bloc.dart';

abstract class ThemeManagerEvent extends Equatable {
  const ThemeManagerEvent();
}

class ChangeThemeMode extends ThemeManagerEvent {
  final ThemeMode themeMode;

  ChangeThemeMode({required this.themeMode});

  @override
  List<Object?> get props => [themeMode];
}

class Init extends ThemeManagerEvent {
  @override
  List<Object?> get props => [];
}

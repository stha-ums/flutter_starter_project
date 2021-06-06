part of 'localization_manager_bloc.dart';

abstract class LocalizationManagerEvent extends Equatable {
  const LocalizationManagerEvent();
}

class ChangeLocale extends LocalizationManagerEvent {
  final Locale locale;

  ChangeLocale({required this.locale});

  @override
  List<Object?> get props => [locale];
}

class InitializeLocale extends LocalizationManagerEvent {
  @override
  List<Object?> get props => [];
}

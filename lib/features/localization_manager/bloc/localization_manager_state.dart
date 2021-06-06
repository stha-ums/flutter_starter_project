part of 'localization_manager_bloc.dart';

class LocalizationManagerState extends Equatable {
  final Locale? locale;
  final bool initialized;
  LocalizationManagerState({this.locale,this.initialized = false});
  @override
  List<Object?> get props => [locale];
}

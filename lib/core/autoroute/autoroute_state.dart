part of 'autoroute_cubit.dart';

class AutorouteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AutorouteInitialState extends AutorouteState {
  @override
  List<Object?> get props => [];
}

class AppRouterCallback extends AutorouteState {
  final AsyncCallbackWithRouter callback;

  AppRouterCallback({
    required this.callback,
  });

  @override
  List<Object?> get props => [callback];
}

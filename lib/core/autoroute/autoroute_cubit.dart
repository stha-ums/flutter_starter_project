import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'autoroute_state.dart';

typedef AsyncCallbackWithRouter = void Function(BuildContext context);

class AutorouteCubit extends Cubit<AutorouteState> {
  AutorouteCubit() : super(AutorouteInitialState());

  routingEvent(AsyncCallbackWithRouter callback) {
    emit(AppRouterCallback(callback: callback));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'autoroute_state.dart';

typedef AsyncCallbackWithRouter = void Function(BuildContext context);

class AutorouteCubit extends Cubit<AutorouteState> {
  AutorouteCubit() : super(AutorouteInitialState());

  routingEvent(AsyncCallbackWithRouter callback) {
    emit(AppRouterCallback(callback: callback));
  }
}

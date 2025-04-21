part of '../core.dart';

abstract class CoreCubit<State extends CoreState> extends Cubit<State> {
  CoreCubit(State state) : super(state);
}

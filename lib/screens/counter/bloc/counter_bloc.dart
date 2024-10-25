import 'package:flutter_application_1/screens/counter/bloc/counter_event.dart';
import 'package:flutter_application_1/screens/counter/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<IncrementCounter>((event, emit) {
      final currentState = state;
      emit(CounterState(currentState.counterValue + 1));
    });

    on<DecrementCounter>((event, emit) {
      final currentState = state;
      emit(CounterState(currentState.counterValue - 1));
    });
  }
}

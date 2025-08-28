import 'package:counter_with_cubit/bloc/counter_event.dart';
import 'package:counter_with_cubit/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterBlocState> {
  CounterBloc() : super(CounterUpdated(0)) {
    on((event, emit) async {
      if (event is IncrementEvent) {
        await increment(emit);
      } else if (event is DecrementEvent) {
        await decrement(emit);
      }
    });
  }

  int counter = 0;

  Future<void> increment(Emitter<CounterBlocState> emit) async {
    emit(CounterLoading());
    await Future.delayed(const Duration(seconds: 1));
    counter++;
    emit(CounterUpdated(counter));
  }

  Future<void> decrement(Emitter<CounterBlocState> emit) async {
    emit(CounterLoading());
    await Future.delayed(const Duration(seconds: 1));
    counter--;
    emit(CounterUpdated(counter));
  }
}

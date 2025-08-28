import 'package:counter_with_cubit/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  int counter = 0;

  add() async {
    emit(CounterLoading());
    await Future.delayed(const Duration(seconds: 1));
    counter++;
    emit(CounterUpdated());
  }

  remove() async {
    emit(CounterLoading());
    await Future.delayed(const Duration(seconds: 1));
    counter--;
    emit(CounterUpdated());
  }
}

class CounterBlocState {}

class CounterInitial extends CounterBlocState {}

class CounterLoading extends CounterBlocState {}

class CounterUpdated extends CounterBlocState {
  int counter;
  CounterUpdated(this.counter);
}

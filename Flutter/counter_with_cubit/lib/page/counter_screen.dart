import 'package:counter_with_cubit/bloc/counter_bloc.dart';
import 'package:counter_with_cubit/bloc/counter_event.dart';
import 'package:counter_with_cubit/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: BlocConsumer<CounterBloc, CounterBlocState>(
          listener: (context, state) {
            if (state is CounterUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Counter updated to ${(context.read<CounterBloc>()).counter}',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          builder: (context, state) {
            var bloc = context.read<CounterBloc>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is CounterUpdated)
                  Center(
                    child: Text(
                      state.counter.toString(),
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                if (state is CounterLoading)
                  const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        bloc.add(DecrementEvent());
                      },
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 20),
                    FloatingActionButton(
                      elevation: 0,
                      onPressed: () {
                        bloc.add(IncrementEvent());
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

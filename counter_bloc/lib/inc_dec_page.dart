import 'package:counter_bloc/bloc/counter_bloc.dart';
import 'package:counter_bloc/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncDecPage extends StatelessWidget {
  const IncDecPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final counterCubit = BlocProvider.of<CounterCubit>(context);

    final counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.navigate_before),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.add(CounterIncremented());
              // counterCubit.decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.add(CounterDecremented());
              // counterCubit.increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

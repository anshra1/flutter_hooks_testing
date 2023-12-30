import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      home: const StateAction(),
    );
  }
}

class CounterState {
  int counter = 0;
  CounterState({required this.counter});
}

class CounterAction {
  int actionCounter = 0;

  CounterAction({required this.actionCounter});
}

CounterState reducer(CounterState state, CounterAction action) {
  return CounterState(counter: (state.counter + action.actionCounter));
}

class StateAction extends HookWidget {
  const StateAction({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer(
      (state, action) => reducer(state,action),
      initialState: CounterState(counter: 0),
      initialAction: CounterAction(actionCounter: 1),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${store.state.counter}'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          store.dispatch(
            CounterAction(actionCounter: 1),
          );
        },
        child: const Text('Increase'),
      )),
    );
  }
}

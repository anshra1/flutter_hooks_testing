import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
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
  int counter;
  CounterState({required this.counter});
}

class CounterAction {
  int actionCounter = 0;

  CounterAction({required this.actionCounter});

  CounterAction increment() {
    return CounterAction(actionCounter: actionCounter + 10);
  }

  CounterAction decrement() {
    return CounterAction(actionCounter: actionCounter - 10);
  }
}

CounterState reducer(CounterState state, CounterAction action) {
  if (state.counter < 0) {
    return CounterState(counter: 0);
  }
  return CounterState(
    counter: (state.counter + action.actionCounter),
  );
}

class StateAction extends HookWidget {
  const StateAction({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer((state, action) => reducer(state, action),
        initialState: CounterState(counter: 0),
        initialAction: CounterAction(actionCounter: 9));

    int s = store.state.counter;
    //  this is important step to control decrease value
    if (s < 0) {
      s = 0;
    }
    useState<Map>({});

    return Scaffold(
      appBar: AppBar(
        title: Text('${s}'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                store.dispatch(CounterAction(actionCounter: 0).increment());
              },
              child: const Text('Increase'),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () {
                store.dispatch(CounterAction(actionCounter: 0).decrement());
              },
              child: const Text('Decrease'),
            ),
          ],
        ),
      ),
    );
  }
}

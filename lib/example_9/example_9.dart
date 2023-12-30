import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage2(title: 'Flutter Demo Home Page',),
    );
  }
}

class State {
  int counter = 0;
}

class IncrementAction {
  int count;
  IncrementAction({required this.count});
}

class MyHomePage2 extends HookWidget {
  MyHomePage2({required this.title}) : super();

  final String title;

  final State initialState = State();

  State reducer(State state, action) {
    if (action is IncrementAction) {
      state.counter = state.counter + action.count;
    }
    return state;
  }

  @override
  Widget build(BuildContext context) {
    final store = useReducer(reducer, initialState: initialState, initialAction: initialState);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${store.state.counter}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => store.dispatch(IncrementAction(count: 1) as State),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


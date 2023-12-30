import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

enum Action {
  rotateLeft,
  rotateRight,
  moreVisible,
  lessVisible,
}

const url = 'https://shorturl.at/hlrux';

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
      home: const HomePage(),
    );
  }
}

States reducer(States oldState, Action? action) {
  switch (action) {
    case null:
      return oldState;

    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.moreVisible();
    case Action.lessVisible:
      return oldState.lessVisible();
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<States, Action?>(
      reducer,
      initialState: const States.zer(),
      initialAction: null,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks Testing'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  store.dispatch(Action.rotateLeft);
                },
                child: const Text('RLeft'),
              ),
              ElevatedButton(
                onPressed: () {
                  store.dispatch(Action.rotateRight);
                },
                child: const Text('RRight'),
              ),
              ElevatedButton(
                onPressed: () {
                  store.dispatch(Action.lessVisible);
                },
                child: const Text('- Alpha'),
              ),
              TextButton(
                onPressed: () {
                  store.dispatch(Action.moreVisible);
                },
                child: const Text('+ Alpha'),
              ),
            ],
          ),
          const Gap(20),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(
                store.state.rotationDeg / 360,
              ),
              child: Image.network(url),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class States {
  final double rotationDeg;
  final double alpha;

  const States({required this.rotationDeg, required this.alpha});

  const States.zer()
      : rotationDeg = 0,
        alpha = 1;

  States rotateRight() => States(
        alpha: alpha,
        rotationDeg: rotationDeg + 10,
      );
  States rotateLeft() => States(
        rotationDeg: rotationDeg - 10,
        alpha: alpha,
      );
  States lessVisible() => States(
        rotationDeg: rotationDeg,
        alpha: min(alpha + 0.1, 1),
      );
  States moreVisible() => States(
        rotationDeg: rotationDeg,
        alpha: max(alpha - 0.1, 0),
      );
}

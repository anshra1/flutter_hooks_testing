import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() async {
  runApp(const MyApp());
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
      home: const HomePage(),
    );
  }
}

const url = 'https://shorturl.at/hlrux';
const imageHeight = 300.0;

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;

    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      },
    );
    print('check build ');

    var r = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: StreamBuilder(
        stream: controller.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final rotation = snapshot.data;
          print('rotation $rotation');
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return GestureDetector(
              onDoubleTap: () {
                r.value = r.value - 10;
              },
              onTap: () {
                controller.sink.add(rotation + 10);
                //   r.value = r.value + 10;
              },
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(rotation / 360),
                child: Center(
                  child: Image.network(url),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

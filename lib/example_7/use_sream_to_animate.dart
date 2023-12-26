import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

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
      home: HomePage(),
    );
  }
}

const url = 'https://shorturl.at/hlrux';
const imageHeight = 300.0;

class HomePage extends HookWidget {
  HomePage({super.key});

  final s = Stream<int>.periodic(const Duration(seconds: 1), (v) {
    return v;
  }).takeWhile((v) => v < 13);

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0,
      upperBound: 1,
    );

    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0,
      upperBound: 1,
    );

    final data = useStream(s);

    var ss = useState(0);
    ss.value = data.data ?? 0;

    ss.addListener(() {
      final newOpacity = max(imageHeight - (ss.value * 25), 0.0);
      final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();
      opacity.value = normalized;
      size.value = normalized;
      print(' state ${data.data} size ${size.value}');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Stram Testing ${ss.value}'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Center(
                child: Image.network(
                  url,
                  height: imageHeight,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: () {
              ss.value--;
            },
            child: const Text('Button'),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: () {
              size.value = 1;
              opacity.value = 1;
              
            },
            child: const Text('Increase'),
          )
        ],
      ),
    );
  }
}

extension Normalize on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizeMaxRange = 1.0,
  ]) =>
      (normalizeMaxRange - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}

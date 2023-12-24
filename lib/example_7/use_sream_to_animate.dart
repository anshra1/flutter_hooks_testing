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
    var n = useState(0);

    final stream = Stream.periodic(const Duration(seconds: 1));

    stream.listen((event) {
      n.value++;
      print(event);
    });

    // var timer = useStream(s);

    useEffect(() {
      n.addListener(() {
        final newOpacity = max(imageHeight - n.value, 0.0);
        final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });

      return null;
    }, [
      n,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('timer.data.toString()'),
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
              n.value = n.value + 10;
              print(n.value);
            },
            child: const Text('Button'),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: () {
              n.value = n.value - 10;
              print(n.value);
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

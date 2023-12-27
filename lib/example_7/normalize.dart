import 'dart:math';

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
    final animationValue = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 0.5,
      lowerBound: 0,
      upperBound: 1,
    );

    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();

        animationValue.value = normalized;
      });

      return null;
    }, [
      controller,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: animationValue,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: animationValue,
              child: Center(
                child: Image.network(
                  url,
                  height: imageHeight,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Person $index'),
                );
              },
            ),
          ),
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

class MyScrollableWidget extends StatefulWidget {
  const MyScrollableWidget({super.key});

  @override
  State<MyScrollableWidget> createState() => _MyScrollableWidgetState();
}

class _MyScrollableWidgetState extends State<MyScrollableWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double offset = _scrollController.offset;
    // Do something with the scroll offset
    print('Scroll offset: $offset');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

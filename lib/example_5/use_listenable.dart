import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

void main() async {
  runApp(const MyApp());
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;

  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1), (v) => from - v)
        .takeWhile((element) => element >= 0)
        .listen((event) {
      value = event;
    });
  }
  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
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

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CountDown counter = CountDown(from: 2);

    final timer = useMemoized(() => counter);
    print("object");
    final notifier = useListenable(timer);
    // use useListenablee with useMemoized

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              notifier.value.toString(),
              style: const TextStyle(fontSize: 40),
            ),
            const Gap(5),
            const HomePaged(),
          ],
        ),
      ),
    );
  }
}

class HomePaged extends HookWidget {
  const HomePaged({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useMemoized(() => CountDown(from: 6));
    final notifier = useState(counter.value);

    useEffect(() {
      counter.addListener(() {
        notifier.value = counter.value;
      });

      return null;
    }, [counter]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Value is ${notifier.value.toString()}',
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends ValueNotifier<int> {
  Counter() : super(0);

  void increment() {
    value++;
  }
}

class MyApped extends StatelessWidget {
  final Counter counter = Counter();

  MyApped({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ValueNotifier Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Counter Value:',
                style: TextStyle(fontSize: 20),
              ),
              ValueListenableBuilder<int>(
                valueListenable: counter,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 40),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  counter.increment();
                },
                child: const Text('Increment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

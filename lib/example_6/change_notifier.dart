import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
      ListModel model = useMemoized(() => ListModel());
    final notifier = useListenable(model);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var random = Random().nextInt(11);
          notifier.add(random);
          print(notifier.li);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notifier.li.length,
        itemBuilder: (context, index) {
          final text = notifier.li.elementAt(index);
          return Center(
            child: Text(
              text.toString(),
              style: const TextStyle(fontSize: 22),
            ),
          );
        },
      ),
    );
  }
}

class ListModel extends ChangeNotifier {
  final List<int>list = [];

  List<int> get li => list;

  void add(int number) {
    list.add(number);
    notifyListeners();
  }
}

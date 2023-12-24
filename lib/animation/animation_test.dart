import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      
      duration: const Duration(seconds: 5),
    );
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller);
    sizeAnimation = Tween<double>(begin: 0, end: 100).animate(controller);

    controller.addListener(() {
      setState(() { });
    });

    controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation Demo"),
      ),
      body: Center(
          child: Container(
        height: sizeAnimation.value,
        width: sizeAnimation.value,
        //     color: colorAnimation.value,
        child: CircleAvatar(backgroundColor: colorAnimation.value),
      )),
    );
  }
}

extension on double {
  leaveExtra() => truncate();
}

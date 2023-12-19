import 'package:flutter/material.dart';

void main() {
  final controller = TextEditingController();

  controller.addListener(() {
    print('Text changed: ${controller.text}');
  });

  runApp(MyApp(controller: controller, key: null,));
}

class MyApp extends StatelessWidget {
  final TextEditingController controller;

  const MyApp({ Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text Input Example'),
        ),
        body: Center(
          child: TextField(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tasks/src/components/TaskList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: TaskList(
        key: key,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

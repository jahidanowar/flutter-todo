import 'package:flutter/material.dart';
import 'package:todo/screens/todoList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: TodoList(),
    );
  }
}

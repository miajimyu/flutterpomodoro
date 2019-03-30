import 'package:flutter/material.dart';

import './pomodoro_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pomodoro Timer', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
        ),
        body: Page(),
      ),
    );
  }
}

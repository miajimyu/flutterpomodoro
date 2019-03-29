import 'package:flutter/material.dart';

import './timer_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pomodoro Timer'),
        ),
        body: Page(),
      ),
    );
  }
}

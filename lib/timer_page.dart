import 'package:flutter/material.dart';

import 'dart:async';

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  Stopwatch _sw;
  Timer _timer;
  Duration elapsed = Duration();

  final workTime = Duration(minutes: 25);
  final breakTime = Duration(minutes: 5);

  // final workTime = Duration(seconds: 5);
  // final breakTime = Duration(seconds: 2);

  @override
  void initState() {
    _sw = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 30), _callback);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void _callback(Timer timer) {
    print('callback');
    if (_sw.elapsed > workTime) {
      _sw.stop();
    }

    var newElapsed = workTime - _sw.elapsed;
    if (newElapsed != elapsed) {
      setState(() {
        elapsed = newElapsed;
      });
    }
  }

  void _resetButtonPressed() {
    if (!_sw.isRunning) {
      _sw.reset();
    }
  }

  void _buttonPressed() {
    if (_sw.isRunning) {
      _sw.stop();
    } else {
      _sw.start();
    }
  }

  String getTimeString() {
    String minutes = (elapsed.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return ("$minutes:$seconds");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            getTimeString(),
            style: TextStyle(fontSize: 72.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Ink(
                decoration: ShapeDecoration(
                  color: Colors.blueAccent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(_sw.isRunning ? null : Icons.autorenew),
                  color: Colors.white,
                  onPressed: () => _resetButtonPressed(),
                ),
              ),
              Ink(
                decoration: ShapeDecoration(
                  color: Colors.blueAccent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(_sw.isRunning ? Icons.pause : Icons.play_arrow),
                  color: Colors.white,
                  onPressed: () => _buttonPressed(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'dart:async';

// final workTime = Duration(minutes: 25);
// final shortBreakTime = Duration(minutes: 5);
// final longBreakTime = Duration(minutes: 15);
final longBreakAfter = 3;
final workTime = Duration(seconds: 5);
final shortBreakTime = Duration(seconds: 2);
final longBreakTime = Duration(seconds: 3);

enum Status {
  work,
  shortBreak,
  longBreak,
}

class Pomodoro {
  Duration targetTime;
  Status status;
  int count;

  Pomodoro({
    this.targetTime,
    this.status,
    this.count,
  });
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  Stopwatch _sw;
  Timer _timer;
  Duration _timeLeft = Duration();

  Pomodoro _pomodoro = Pomodoro(
    targetTime: workTime,
    status: Status.work,
    count: 0,
  );

  @override
  void initState() {
    _pomodoro.targetTime = workTime;
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
    var _newTimeLeft = _pomodoro.targetTime - _sw.elapsed;
    if (_newTimeLeft != _timeLeft) {
      setState(() {
        _timeLeft = _newTimeLeft;
      });
    }

    if (_sw.elapsed > _pomodoro.targetTime) {
      setState(() {
        _changeNextStatus();
      });
    }
  }

  void _changeNextStatus() {
    _sw.stop();
    _sw.reset();
    if (_pomodoro.status == Status.work) {
      _pomodoro.count++;
      if (_pomodoro.count % longBreakAfter == 0) {
        _pomodoro.targetTime = longBreakTime;
        _pomodoro.status = Status.longBreak;
      } else {
        _pomodoro.targetTime = shortBreakTime;
        _pomodoro.status = Status.shortBreak;
      }
    } else {
      _pomodoro.targetTime = workTime;
      _pomodoro.status = Status.work;
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
    String minutes = (_timeLeft.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (_timeLeft.inSeconds % 60).toString().padLeft(2, '0');
    return ("$minutes:$seconds");
  }

  Widget displayPomodoroStatus() {
    String text;
    if (_pomodoro.status == Status.shortBreak) {
      text = 'Short Break';
    } else if (_pomodoro.status == Status.longBreak) {
      text = 'Long Break';
    } else {
      text = 'Work';
    }

    return Text(
      text,
      style: TextStyle(fontSize: 30.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        displayPomodoroStatus(),
        Text(
          getTimeString(),
          style: TextStyle(fontSize: 100.0),
        ),
        Text(
          _pomodoro.count.toString(),
          style: TextStyle(fontSize: 40.0),
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
                iconSize: 72,
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
                iconSize: 72,
                onPressed: () => _buttonPressed(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

# flutterpomodoro

Pomodoro Timer by Flutter.

<img src="screenshots/flutterpomodoro.gif" width="240px">

## Description

This is simple pomodoro timer.

- The current status: displayed above the timer. Like "Work".  
- Timer: This timer have three states.  
"Work" 25 minutes, "Short Break" 5 minutes and "Long Break" 15 minutes per 3 works.  
- The current intervals: displayed below the timer. Like "0/6", "1/6".  
- Left Button: Timer refresh. This button is enable when timer is not running.  
- Right Button: Timer start / stop.  

The color of the button and indicator changes in each state.

## Code size

```
> find . -name "*.dart" | xargs cat | wc -c
5119
```

## License

MIT.

This app is supported by [percent_indicator](https://pub.dartlang.org/packages/percent_indicator).

# Custom Calendar Viewer

<a href="https://pub.dev/packages/animated_toggle"><img src="https://img.shields.io/pub/v/custom_calendar_viewer.svg" alt="Pub"></a>
<a href="https://pub.dev/packages/animated_toggle/score"><img src="https://img.shields.io/pub/likes/custom_calendar_viewer?logo=flutter" alt="Pub likes"></a>
<a href="https://pub.dev/packages/animated_toggle/score"><img src="https://img.shields.io/pub/popularity/custom_calendar_viewer?logo=flutter" alt="Pub popularity"></a>
<a href="https://pub.dev/packages/animated_toggle/score"><img src="https://img.shields.io/pub/points/custom_calendar_viewer?logo=flutter" alt="Pub points"></a>

* Amazing package help you to view your plans or important dates in calendar.

![Days and Ranges](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/gifs/V1.gif) ![Ar Ex](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/9.jpeg)
![Ex 1](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/1.jpeg) ![Ex 2](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/2.jpeg) ![Ex 3](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/3.jpeg) ![Ex 4](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/4.jpeg)
![Ex 5](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/5.jpeg) ![Ex 6](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/6.jpeg) ![Ex 7](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/7.jpeg) ![Ex 8](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/8.jpeg)


## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  custom_calendar_viewer: ^Last Version
  ```

## Features

* Amazing package help you to view your plans or important dates in calendar.
* You can add multi dates or multi ranges.
* you can handle the color for each date or you can use active color to give one color for all.
* you can use your own style for each text.
* The package have animation when you moving between months.
* With this package really you will be able to control your calendar view.

## Getting started

```dart
import 'package:custom_calendar_viewer/custom_calendar_viewer.dart';

void main() {

}

// Start use th package in your State Widget
  ```

## What you can handle

```dart
final List<DateTime>? dates;
final List<RangeDate>? ranges;
final List<Color>? datesColors;
final List<Color>? rangesColors;
final Color activeColor;
final Color dropArrowColor;
final Color movingArrowColor;
final Color currentDayBorderColor;
final bool showCurrentDayBorderColor;
final double dropArrowSize;
final double movingArrowSize;
final TextStyle headerStyle;
final TextStyle dayNameStyle;
final TextStyle dayNumStyle;
final TextStyle activeDayNumStyle;
final TextStyle dropDownYearsStyle;
final String local;
```

## Usage

**For Full Example Go To Example Tap**

```dart
CustomCalendarViewer(
          dates: [
            DateTime.now().subtract(const Duration(days: 2)),
            DateTime.now().subtract(const Duration(days: 3)),
            DateTime.now().subtract(const Duration(days: 5)),
            DateTime.now().add(const Duration(days: 16)),
            DateTime.now().add(const Duration(days: 18)),
            DateTime.now().add(const Duration(days: 19)),
            DateTime.now().add(const Duration(days: 24)),
          ],
          datesColors: const [
            Colors.amber,
            Colors.red,
            Colors.amber,
            Colors.blue,
            Colors.red,
            Colors.amber,
            Colors.amber,
          ],
          ranges: [
            RangeDate(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 4))),
            RangeDate(start: DateTime.now().add(const Duration(days: 6)), end: DateTime.now().add(const Duration(days: 11))),
            RangeDate(start: DateTime.now().add(const Duration(days: 13)), end: DateTime.now().add(const Duration(days: 15))),
          ],
          rangesColors: const [
            Colors.red,
            Colors.amber,
            Colors.blue,
          ],
          showCurrentDayBorderColor: false,
),
```

## Additional information

Say to me in GitHub what you need to see in the package in the next update.
Wait for more feature soon.

## Author

[Loay Omar](https://github.com/LoayOmar)
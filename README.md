# Custom Calendar Viewer

<a href="https://pub.dev/packages/custom_calendar_viewer"><img src="https://img.shields.io/pub/v/custom_calendar_viewer.svg" alt="Pub"></a>
<a href="https://pub.dev/packages/custom_calendar_viewer/score"><img src="https://img.shields.io/pub/likes/custom_calendar_viewer?logo=flutter" alt="Pub likes"></a>
<a href="https://pub.dev/packages/custom_calendar_viewer/score"><img src="https://img.shields.io/pub/popularity/custom_calendar_viewer?logo=flutter" alt="Pub popularity"></a>
<a href="https://pub.dev/packages/custom_calendar_viewer/score"><img src="https://img.shields.io/pub/points/custom_calendar_viewer?logo=flutter" alt="Pub points"></a>

* Amazing package help you to view your plans or important dates in calendar.

| ![V2](https://github.com/LoayOmar/Custom_Calendar_Viewer/blob/master/assets/gifs/V2.gif) | ![V3](https://github.com/LoayOmar/Custom_Calendar_Viewer/blob/master/assets/gifs/V3.gif) | ![V3](https://github.com/LoayOmar/Custom_Calendar_Viewer/blob/master/assets/gifs/V4.gif) |
|:--------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------:|

|         ![Days and Ranges](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/gifs/V1.gif)          |             ![Ar Ex](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/9.jpeg)             |             ![Ex 1](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/1.jpeg)              |            ![Ex 2](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/2.jpeg)             |
|:--------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------:|

| ![Ex 3](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/3.jpeg) | ![Ex 4](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/4.jpeg) | ![Ex 5](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/5.jpeg) | ![Ex 10](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/10.jpeg) |
|:------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------:|

| ![Ex 6](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/6.jpeg) | ![Ex 7](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/7.jpeg) | ![Ex 8](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/8.jpeg) | ![Ex 11](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/11.jpeg) |
|:------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------:|

| ![Ex 12](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/12.jpeg) | ![Ex 13](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/13.jpeg) | ![Ex 13](https://raw.githubusercontent.com/LoayOmar/Custom_Calendar_Viewer/master/assets/images/14.jpeg) |
|:--------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------:|

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
* You can handel the color for each active day (Text or Background).
* You can use Tooltip to give more info about this day.
* Now you can add multiple dates or ranges when the application is started.
* You can handle the color for background or the text color when you add new ranges or dates.

## Getting started

```dart
import 'package:custom_calendar_viewer/custom_calendar_viewer.dart';

void main() {

}

// Start use th package in your State Widget
  ```

## What you can handle

```dart
final List<Date>? dates;
final List<RangeDate>? ranges;
final Function(DateTime date)? onDayTapped;
final Function(List<Date>)? onDatesUpdated;
final Function(List<RangeDate>)? onRangesUpdated;
final Color activeColor;
final Color dropArrowColor;
final Color movingArrowColor;
final Color headerBackground;
final Color daysHeaderBackground;
final Color daysBodyBackground;
final Border? currentDayBorder;
final Border? dayBorder;
final bool showCurrentDayBorder;
final bool showHeader;
final double dropArrowSize;
final double movingArrowSize;
final double radius;
final TextStyle headerStyle;
final TextStyle dayNameStyle;
final TextStyle dayNumStyle;
final TextStyle activeDayNumStyle;
final TextStyle dropDownYearsStyle;
final String local;
final Duration duration;
final Duration yearDuration;
final double headerMarginLeft;
final double headerMarginRight;
final double headerMarginTop;
final double headerMarginBottom;
final double daysMarginLeft;
final double daysMarginRight;
final double daysMarginTop;
final double daysMarginBottom;
final String toolTipMessage;
final double? toolTipHeight;
final EdgeInsets? toolTipPadding;
final EdgeInsets? toolTipMargin;
final bool toolTipPreferBelow;
final TooltipTriggerMode toolTipTriggerMode;
final Decoration? toolTipDecoration;
final TextStyle? toolTipTextStyle;
final TextAlign? toolTipTextAlign;
final Duration? toolTipWaitDuration;
final Duration? toolTipShowDuration;
final bool showTooltip;
final bool addNewDates;
final Color addDatesIndicatorColor;
final Color addDatesIndicatorActiveColor;
final TextStyle addDatesTextStyle;
final TextStyle addDatesActiveTextStyle;
final EdgeInsets addDatesMargin;
```

## Usage

**For Full Example Go To Example Tap**

```dart
    CustomCalendarViewer(
        dates: [
            Date(
                date: DateTime(2023, 11, 8),
                color: Colors.red,
            ),
            Date(
                date: DateTime(2023, 11, 10),
                color: Colors.amber,
            ),
            Date(
                date: DateTime(2023, 11, 7),
                color: Colors.amber,
            ),
            Date(
                date: DateTime(2023, 11, 1),
                color: Colors.red,
            ),
            Date(
                date: DateTime(2023, 11, 4),
                color: Colors.white,
                textColor: Colors.red,
            ),
            Date(
                date: DateTime(2023, 11, 5),
                color: Colors.white,
                textColor: Colors.red,
            ),
            Date(
                date: DateTime(2023, 11, 18),
                color: Colors.blue,
            ),
            Date(
              date: DateTime(2023, 11, 22),
            ),
        ],
        ranges: [
            RangeDate(
                start: DateTime(2023, 11, 12),
                end: DateTime(2023, 11, 15),
                color: Colors.red,
            ),
            RangeDate(
                start: DateTime(2023, 11, 24),
                end: DateTime(2023, 11, 27),
                color: Colors.amber,
            ),
            RangeDate(
                start: DateTime(2023, 11, 30),
                end: DateTime(2023, 11, 29),
            ),
        ],
        showCurrentDayBorder: false,
    ),
```

## Additional information

* Say to me in GitHub what you need to see in the package in the next update.
* Wait for more feature soon.

## Author

[Loay Omar](https://github.com/LoayOmar)
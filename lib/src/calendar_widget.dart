import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'models/date_model.dart';
import 'models/range_model.dart';

enum CustomCalendarType {
  none,
  date,
  range,
  multiDates,
  multiRanges,
  multiDatesAndRanges,
}

class CustomCalendarViewer extends StatefulWidget {
  /// - Here you can add specific active days dates
  /// - This  will take Date Model
  /// - if you leave the color or text color null this will take the colors from active color for background and active day num style for text color
  final List<Date>? dates;

  /// - Here you can add specific active ranges dates
  /// - This  will take RangeDate Model
  /// - if you leave the color or text color null this will take the colors from active color for background and active day num style for text color
  final List<RangeDate>? ranges;

  /// - This function will give you the date for the day that's tapped
  final Function(DateTime date)? onDayTapped;

  /// - This function will give you the updated lest for dates
  final Function(List<Date>)? onDatesUpdated;

  /// - This function will give you the updated lest for dates
  final Function(List<RangeDate>)? onRangesUpdated;

  ///- There's 5 types to handle your calendar
  ///   - CustomCalendarType.none this will make the user can't press on the calendar
  ///   - CustomCalendarType.date this will make the user can add only one date
  ///   - CustomCalendarType.range this will make the user to add only one range
  ///   - CustomCalendarType.multiDates this will make the user can add multiple dates
  ///   - CustomCalendarType.multiRanges this will make the user can add multiple ranges
  ///   - CustomCalendarType.multiDatesAndRanges this will make the user can add multiple dates and ranges
  final CustomCalendarType calendarType;

  /// - Here you can control the active color
  final Color activeColor;

  /// - Here you can control the drop down arrow color
  final Color dropArrowColor;

  /// - Here you can control the moving arrow color
  final Color movingArrowColor;

  /// - You can use specific header background color for your calendar
  final Color headerBackground;

  /// - You can use specific days header background color for your calendar
  final Color daysHeaderBackground;

  /// - You can use specific days body background color for your calendar
  final Color daysBodyBackground;

  /// - Here you can customize you current day border or this will use default border
  final Border? currentDayBorder;

  /// - If you need to add border for all days expect the current day
  final Border? dayBorder;

  /// - You can control if you need to show the border for current day or not default is true
  final bool showCurrentDayBorder;

  /// - If this true the header will be shown
  final bool showHeader;

  /// - From here you can control the size for drop down arrow size
  final double dropArrowSize;

  /// - From here you can control the moving arrow size
  final double movingArrowSize;

  /// - you can control the radius for the active days
  final double radius;

  /// - From these you can handel the style for header text in the calendar
  final TextStyle headerStyle;

  /// - From these you can handel the style for day name text in the calendar
  final TextStyle dayNameStyle;

  /// - From these you can handel the style for day number text in the calendar
  final TextStyle dayNumStyle;

  /// - From these you can handel the style for active day number text in the calendar
  final TextStyle activeDayNumStyle;

  /// - From these you can handel the style for years text in the dropDown
  final TextStyle dropDownYearsStyle;

  /// - You can use 'ar' to show the calendar Arabic or 'en'(default) for English
  final String local;

  /// - This the duration for the calender when change the month
  final Duration duration;

  /// - This the duration for the years when open the years widget
  final Duration yearDuration;

  /// - The empty space that surrounds the header.
  final EdgeInsets headerMargin;

  /// - The empty space that surrounds the the days body.
  final EdgeInsets daysMargin;

  // - ToolTip Style

  /// - The text to display in the tooltip. Only one of message.
  final String toolTipMessage;

  /// - The height of the tooltip's child.
  /// - If the child is null, then this is the tooltip's intrinsic height.
  final double? toolTipHeight;

  /// - The amount of space by which to inset the tooltip's child.
  /// - On mobile, defaults to 16.0 logical pixels horizontally and 4.0 vertically.
  /// - On desktop, defaults to 8.0 logical pixels horizontally and 4.0 vertically.
  final EdgeInsets? toolTipPadding;

  /// - The empty space that surrounds the tooltip.
  /// - Defines the tooltip's outer Container.margin. By default, a long tooltip will span the width of its window. If long enough, a tooltip might also span the window's height. This property allows one to define how much space the tooltip must be inset from the edges of their display window.
  /// - If this property is null, then TooltipThemeData.margin is used. If TooltipThemeData.margin is also null, the default margin is 0.0 logical pixels on all sides.
  final EdgeInsets? toolTipMargin;

  /// - Whether the tooltip defaults to being displayed below the widget.
  /// - Defaults to true. If there is insufficient space to display the tooltip in the preferred direction, the tooltip will be displayed in the opposite direction.
  final bool toolTipPreferBelow;

  /// - The TooltipTriggerMode that will show the tooltip.
  /// - If this property is null, then TooltipThemeData.triggerMode is used. If TooltipThemeData.triggerMode is also null, the default mode is TooltipTriggerMode.longPress.
  /// - This property does not affect mouse devices. Setting triggerMode to TooltipTriggerMode.manual will not prevent the tooltip from showing when the mouse cursor hovers over it.
  final TooltipTriggerMode toolTipTriggerMode;

  /// - Specifies the tooltip's shape and background color.
  /// - The tooltip shape defaults to a rounded rectangle with a border radius of 4.0. Tooltips will also default to an opacity of 90% and with the color Colors.grey\700\ if ThemeData.brightness is Brightness.dark, and Colors.white if it is Brightness.light.
  final Decoration? toolTipDecoration;

  /// - The style to use for the message of the tooltip.
  /// - If null, the message's TextStyle will be determined based on ThemeData.
  /// - If ThemeData.brightness is set to Brightness.dark, TextTheme.bodyMedium of ThemeData.textTheme will be used with Colors.white. Otherwise, if ThemeData.brightness is set to Brightness.light, TextTheme.bodyMedium of ThemeData.textTheme will be used with Colors.black.
  final TextStyle? toolTipTextStyle;

  /// - How the message of the tooltip is aligned horizontally.
  /// - If this property is null, then TooltipThemeData.textAlign is used. If TooltipThemeData.textAlign is also null, the default value is TextAlign.start.
  final TextAlign? toolTipTextAlign;

  /// - The length of time that a pointer must hover over a tooltip's widget before the tooltip will be shown.
  /// - Defaults to 0 milliseconds (tooltips are shown immediately upon hover).
  final Duration? toolTipWaitDuration;

  /// - The length of time that the tooltip will be shown after a long press is released (if triggerMode is TooltipTriggerMode.longPress) or a tap is released (if triggerMode is TooltipTriggerMode.tap) or mouse pointer exits the widget.
  /// - Defaults to 1.5 seconds for long press and tap released or 0.1 seconds for mouse pointer exits the widget.
  final Duration? toolTipShowDuration;

  /// - If this true the Tooltip will be active
  final bool showTooltip;

  // Add New Dates
  /// - The color of the indicator when this not selected
  final Color addDatesIndicatorColor;

  /// - The color of the indicator when this selected
  final Color addDatesIndicatorActiveColor;

  /// - The Text style for the indicator text when this not selected
  final TextStyle addDatesTextStyle;

  /// - The Text style for the indicator text when this selected
  final TextStyle addDatesActiveTextStyle;

  /// - The empty space that surrounds the add dates widget.
  final EdgeInsets addDatesMargin;

  const CustomCalendarViewer({
    super.key,
    this.duration = const Duration(milliseconds: 600),
    this.yearDuration = const Duration(milliseconds: 500),
    this.dates,
    this.ranges,
    this.onDayTapped,
    this.onDatesUpdated,
    this.onRangesUpdated,
    this.calendarType = CustomCalendarType.none,
    this.activeColor = Colors.blue,
    this.dropArrowColor = Colors.black,
    this.movingArrowColor = Colors.black,
    this.currentDayBorder,
    this.dayBorder,
    this.headerBackground = Colors.transparent,
    this.daysHeaderBackground = Colors.transparent,
    this.daysBodyBackground = Colors.transparent,
    this.showCurrentDayBorder = true,
    this.showHeader = true,
    this.dropArrowSize = 34,
    this.movingArrowSize = 16,
    this.radius = 40,
    this.headerStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    this.dropDownYearsStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    this.dayNameStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    this.dayNumStyle = const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
    this.activeDayNumStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.white,
    ),
    this.headerMargin =
        const EdgeInsets.only(left: 42, right: 42, top: 8, bottom: 10),
    this.daysMargin =
        const EdgeInsets.only(left: 45, right: 45, top: 0, bottom: 0),
    this.local = 'en',
    this.toolTipMessage = 'Message',
    this.toolTipHeight,
    this.toolTipPadding,
    this.toolTipMargin,
    this.toolTipPreferBelow = false,
    this.toolTipTriggerMode = TooltipTriggerMode.tap,
    this.toolTipDecoration,
    this.toolTipTextStyle,
    this.toolTipTextAlign,
    this.toolTipWaitDuration,
    this.toolTipShowDuration,
    this.showTooltip = false,
    this.addDatesIndicatorColor = Colors.grey,
    this.addDatesIndicatorActiveColor = Colors.blue,
    this.addDatesTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 14,
    ),
    this.addDatesActiveTextStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      fontSize: 14,
    ),
    this.addDatesMargin =
        const EdgeInsets.only(left: 45, right: 45, top: 10, bottom: 0),
  });

  @override
  State<CustomCalendarViewer> createState() => _CustomCalendarViewerState();
}

class _CustomCalendarViewerState extends State<CustomCalendarViewer>
    with SingleTickerProviderStateMixin {
  DateTime currentDate = DateTime.now();
  final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<String> arDays = ['أ', 'ث', 'أ', 'خ', 'ج', 'س', 'ح'];
  final Map<String, String> monthsName = {
    'January': 'يناير',
    'February': 'فبراير',
    'March': 'مارس',
    'April': 'أبريل',
    'May': 'مايو',
    'June': 'يونيو',
    'July': 'يوليو',
    'August': 'أغسطس',
    'September': 'سبتمبر',
    'October': 'أكتوبر',
    'November': 'نوفمبر',
    'December': 'ديسمبر',
  };
  bool showYears = false;

  late AnimationController _controller;
  Tween<Offset> _offsetTween =
      Tween<Offset>(begin: const Offset(0.0, 0.0), end: const Offset(0.0, 0.0));
  late Animation<Offset> _offsetAnimation;
  Date? firstRangeDate;
  int addRange = 0;
  int dateColor = 0;
  int addDates = -1;
  Color addDayColor = Colors.blue;
  Color addDayTextColor = Colors.white;
  Color addRangeColor = Colors.blue;
  Color addRangeTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _offsetAnimation = _offsetTween.animate(_controller);
  }

  List checkInRange(DateTime date) {
    for (int i = 0; i < widget.ranges!.length; i++) {
      final range = widget.ranges![i];
      DateTime start =
          DateTime(range.start.year, range.start.month, range.start.day);
      DateTime end = DateTime(range.end.year, range.end.month, range.end.day);

      if (start == end) {
        widget.dates!.add(
            Date(date: start, color: range.color, textColor: range.textColor));
        widget.ranges!.remove(range);
      } else {
        if (start.isAfter(end)) {
          DateTime switcher = start;
          start = end;
          end = switcher;
        }

        if (date.isAfter(start) && date.isBefore(end)) {
          return [i, 'mid'];
        } else if (date == start) {
          return [i, 'start'];
        } else if (date == end) {
          return [i, 'end'];
        }
      }
    }
    return [-1];
  }

  @override
  Widget build(BuildContext context) {
    int addMonth = 0;
    DateTime firstDayOfNextMonth =
        DateTime(currentDate.year, currentDate.month + (addMonth + 1), 1);
    String firstDay = DateFormat('E')
        .format(DateTime(currentDate.year, currentDate.month + addMonth, 1));
    int daysInMonth = firstDayOfNextMonth.subtract(const Duration(days: 1)).day;
    String month = DateFormat('MMMM')
        .format(DateTime(currentDate.year, currentDate.month + addMonth, 1));
    String year = DateFormat('yyyy')
        .format(DateTime(currentDate.year, currentDate.month + addMonth, 1));
    int extraDays = 0;
    if (firstDay == 'Mon') {
      extraDays = 0;
    } else if (firstDay == 'Tue') {
      extraDays = 1;
    } else if (firstDay == 'Wed') {
      extraDays = 2;
    } else if (firstDay == 'Thu') {
      extraDays = 3;
    } else if (firstDay == 'Fri') {
      extraDays = 4;
    } else if (firstDay == 'Sat') {
      extraDays = 5;
    } else if (firstDay == 'Sun') {
      extraDays = 6;
    }
    int count = extraDays;
    int countYears = -31;

    EdgeInsets edge({
      EdgeInsets padding = EdgeInsets.zero,
    }) {
      return widget.local == 'en'
          ? EdgeInsets.only(
              left: padding.left,
              right: padding.right,
              top: padding.top,
              bottom: padding.bottom,
            )
          : EdgeInsets.only(
              left: padding.right,
              right: padding.left,
              top: padding.top,
              bottom: padding.bottom,
            );
    }

    String convertToArOrEnNumerals(String input) {
      const englishDigits = '0123456789';
      const arabicDigits = '٠١٢٣٤٥٦٧٨٩';

      if (widget.local == 'ar') {
        for (int i = 0; i < englishDigits.length; i++) {
          input = input.replaceAll(englishDigits[i], arabicDigits[i]);
        }
      } else {
        for (int i = 0; i < englishDigits.length; i++) {
          input = input.replaceAll(arabicDigits[i], englishDigits[i]);
        }
      }

      return input;
    }

    void triggerAnimation({required bool toRight}) {
      if (toRight) {
        _offsetTween = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(9.0, 0.0));
        _offsetAnimation = _offsetTween.animate(_controller);
        _controller.forward().then((value) => _controller.reset());
      } else {
        _offsetTween = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(-9.0, 0.0));
        _offsetAnimation = _offsetTween.animate(_controller);
        _controller.forward().then((value) => _controller.reset());
      }
    }

    void backArrow() {
      setState(() {
        triggerAnimation(toRight: widget.local == 'en' ? true : false);
        Future.delayed(widget.duration).then((value) {
          setState(() {
            addMonth--;
            currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
          });
        });
      });
    }

    void forwardArrow() {
      setState(() {
        triggerAnimation(toRight: widget.local == 'en' ? false : true);
        Future.delayed(widget.duration).then((value) {
          setState(() {
            addMonth++;
            currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
          });
        });
      });
    }

    Widget dateDayWidget(
      List<dynamic> inRange,
      int index,
      int extraDays,
      int dateIndex,
    ) {
      return SlideTransition(
        position: _offsetAnimation,
        child: Container(
          alignment: Alignment.center,
          margin: inRange[0] == -1
              ? edge(
                  padding: const EdgeInsets.only(
                      left: 1, right: 1, top: 1, bottom: 1))
              : inRange[1] == 'start'
                  ? edge(
                      padding:
                          const EdgeInsets.only(left: 1, top: 1, bottom: 1))
                  : inRange[1] == 'end'
                      ? edge(
                          padding: const EdgeInsets.only(
                              right: 1, top: 1, bottom: 1))
                      : edge(
                          padding: const EdgeInsets.only(top: 1, bottom: 1),
                        ),
          decoration: BoxDecoration(
            borderRadius: inRange[0] == -1
                ? BorderRadius.circular(widget.radius)
                : inRange[1] == 'start'
                    ? (widget.local == 'en'
                        ? BorderRadius.only(
                            topLeft: Radius.circular(widget.radius),
                            bottomLeft: Radius.circular(widget.radius))
                        : BorderRadius.only(
                            topRight: Radius.circular(widget.radius),
                            bottomRight: Radius.circular(widget.radius)))
                    : inRange[1] == 'end'
                        ? (widget.local == 'en'
                            ? BorderRadius.only(
                                topRight: Radius.circular(widget.radius),
                                bottomRight: Radius.circular(widget.radius))
                            : BorderRadius.only(
                                topLeft: Radius.circular(widget.radius),
                                bottomLeft: Radius.circular(widget.radius)))
                        : BorderRadius.zero,
            border: (DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day) ==
                        DateTime(currentDate.year, currentDate.month,
                            (index + 1) - extraDays) &&
                    widget.showCurrentDayBorder)
                ? widget.currentDayBorder ?? Border.all(color: Colors.blue)
                : widget.dayBorder,
            color: inRange[0] == -1
                ? (dateIndex != -1
                    ? (widget.dates == null ||
                            widget.dates![dateIndex].color == null)
                        ? widget.activeColor
                        : widget.dates![dateIndex].color
                    : Colors.transparent)
                : (widget.ranges == null ||
                        widget.ranges![inRange[0]].color == null)
                    ? widget.activeColor
                    : widget.ranges![inRange[0]].color,
          ),
          child: Text(
            widget.local == 'en'
                ? '${(index + 1) - extraDays}'
                : convertToArOrEnNumerals('${(index + 1) - extraDays}'),
            style: (dateIndex != -1 || inRange[0] != -1)
                ? ((widget.dates != null || widget.ranges != null)
                    ? widget.activeDayNumStyle.copyWith(
                        color: inRange[0] == -1
                            ? (widget.dates![dateIndex].textColor ??
                                widget.activeDayNumStyle.color)
                            : (widget.ranges![inRange[0]].textColor ??
                                widget.activeDayNumStyle.color),
                      )
                    : widget.activeDayNumStyle)
                : widget.dayNumStyle,
          ),
        ),
      );
    }

    Future<dynamic> defaultShowDialog({
      required BuildContext context,
      EdgeInsets? padding,
    }) {
      return showDialog(
        useSafeArea: true,
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) => Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              height: 400,
              margin: edge(padding: const EdgeInsets.only(left: 34, right: 34)),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: edge(padding: const EdgeInsets.all(24)),
                    child: Column(
                      children: [
                        ColorPicker(
                          pickerColor: addDates == 0
                              ? (dateColor == 0 ? addDayColor : addDayTextColor)
                              : (dateColor == 0
                                  ? addRangeColor
                                  : addRangeTextColor),
                          enableAlpha: false,
                          colorPickerWidth: 245,
                          pickerAreaHeightPercent: 0.8,
                          onColorChanged: (Color newColor) {
                            setState(() {
                              if (addDates == 0) {
                                if (dateColor == 0) {
                                  addDayColor = newColor;
                                } else {
                                  addDayTextColor = newColor;
                                }
                              } else {
                                if (dateColor == 0) {
                                  addRangeColor = newColor;
                                } else {
                                  addRangeTextColor = newColor;
                                }
                              }
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            addDatesItem(
                                text: widget.local == 'en'
                                    ? 'Background'
                                    : 'الخلفية',
                                color: dateColor == 0
                                    ? widget.addDatesIndicatorActiveColor
                                    : widget.addDatesIndicatorColor,
                                textStyle: dateColor == 0
                                    ? widget.addDatesActiveTextStyle
                                    : widget.addDatesTextStyle,
                                onTap: () {
                                  setState(() {
                                    dateColor = 0;
                                    Navigator.pop(context);
                                    defaultShowDialog(context: context);
                                  });
                                }),
                            addDatesItem(
                                text: widget.local == 'en'
                                    ? 'Text Color'
                                    : 'لون النص',
                                color: dateColor == 1
                                    ? widget.addDatesIndicatorActiveColor
                                    : widget.addDatesIndicatorColor,
                                textStyle: dateColor == 1
                                    ? widget.addDatesActiveTextStyle
                                    : widget.addDatesTextStyle,
                                onTap: () {
                                  setState(() {
                                    dateColor = 1;
                                    Navigator.pop(context);
                                    defaultShowDialog(context: context);
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: widget.local == 'en'
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: IconButton(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.clear,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            if (widget.showHeader)
              Container(
                margin: edge(
                  padding: widget.headerMargin,
                ),
                color: widget.headerBackground,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.local == 'en' ? month : monthsName[month]!,
                          style: widget.headerStyle,
                        ),
                        Padding(
                          padding: edge(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5)),
                          child: Text(
                            widget.local == 'en'
                                ? year
                                : convertToArOrEnNumerals(year),
                            style: widget.headerStyle,
                          ),
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              showYears = !showYears;
                            });
                          },
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: widget.dropArrowColor,
                            size: widget.dropArrowSize,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            widget.local == 'en' ? backArrow() : forwardArrow();
                          },
                          child: SvgPicture.asset(
                            widget.local == 'en'
                                ? 'assets/icons/back.svg'
                                : 'assets/icons/forward.svg',
                            package: 'custom_calendar_viewer',
                            colorFilter: ColorFilter.mode(
                                widget.movingArrowColor, BlendMode.srcIn),
                            width: widget.movingArrowSize,
                            height: widget.movingArrowSize,
                          ),
                        ),
                        const SizedBox(
                          width: 48,
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            widget.local == 'en' ? forwardArrow() : backArrow();
                          },
                          child: SvgPicture.asset(
                            widget.local == 'en'
                                ? 'assets/icons/forward.svg'
                                : 'assets/icons/back.svg',
                            package: 'custom_calendar_viewer',
                            colorFilter: ColorFilter.mode(
                                widget.movingArrowColor, BlendMode.srcIn),
                            width: widget.movingArrowSize,
                            height: widget.movingArrowSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              height: 40,
              color: widget.daysHeaderBackground,
              margin: edge(
                padding: widget.daysMargin,
              ),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7),
                itemBuilder: (_, index) => Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.local == 'en' ? days[index] : arDays[index],
                      style: widget.dayNameStyle,
                    )),
                itemCount: 7,
              ),
            ),
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity != null) {
                  if (details.primaryVelocity! > 0) {
                    // User dragged from left to right
                    widget.local == 'en' ? backArrow() : forwardArrow();
                  } else {
                    // User dragged from right to left
                    widget.local == 'en' ? forwardArrow() : backArrow();
                  }
                }
              },
              child: Container(
                color: widget.daysBodyBackground,
                margin: edge(
                  padding: widget.daysMargin,
                ),
                height:
                    (extraDays == 6 || (extraDays == 5 && daysInMonth == 31))
                        ? 285
                        : 240,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7),
                  itemBuilder: (_, index) {
                    if (count == 0) {
                      int dateIndex = widget.dates == null
                          ? -1
                          : widget.dates!.indexWhere((Date date) =>
                              date.date.year == currentDate.year &&
                              date.date.month == currentDate.month &&
                              date.date.day == ((index + 1) - extraDays));
                      List inRange = checkInRange(DateTime(currentDate.year,
                          currentDate.month, (index + 1) - extraDays));
                      return widget.showTooltip
                          ? Tooltip(
                              message: widget.toolTipMessage,
                              height: widget.toolTipHeight,
                              padding: widget.toolTipPadding,
                              margin: widget.toolTipMargin,
                              triggerMode: widget.toolTipTriggerMode,
                              preferBelow: widget.toolTipPreferBelow,
                              decoration: widget.toolTipDecoration,
                              textStyle: widget.toolTipTextStyle,
                              textAlign: widget.toolTipTextAlign,
                              waitDuration: widget.toolTipWaitDuration,
                              showDuration: widget.toolTipShowDuration,
                              child: dateDayWidget(
                                inRange,
                                index,
                                extraDays,
                                dateIndex,
                              ),
                            )
                          : InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () {
                                if (widget.calendarType !=
                                    CustomCalendarType.none) {
                                  setState(() {
                                    DateTime date = DateTime(
                                        currentDate.year,
                                        currentDate.month,
                                        index - extraDays + 1);
                                    widget.onDayTapped!(date);
                                    int foundDate = widget.dates!.indexWhere(
                                      (element) =>
                                          DateTime(
                                              element.date.year,
                                              element.date.month,
                                              element.date.day) ==
                                          date,
                                    );
                                    int foundRange = widget.ranges!.indexWhere(
                                        (element) => ((DateTime(
                                                    element.start.year,
                                                    element.start.month,
                                                    element.start.day) ==
                                                date) ||
                                            (DateTime(
                                                    element.end.year,
                                                    element.end.month,
                                                    element.end.day) ==
                                                date) ||
                                            (DateTime(
                                                        element.start.year,
                                                        element.start.month,
                                                        element.start.day)
                                                    .isBefore(date) &&
                                                DateTime(
                                                        element.end.year,
                                                        element.end.month,
                                                        element.end.day)
                                                    .isAfter(date))));
                                    if (widget.calendarType ==
                                        CustomCalendarType.date) {
                                      widget.dates!.clear();
                                      widget.dates!.add(Date(date: date));
                                    } else if (widget.calendarType ==
                                        CustomCalendarType.range) {
                                      if (addRange == 0) {
                                        widget.ranges!.clear();
                                        firstRangeDate = Date(
                                            date: date,
                                            color: addRangeColor,
                                            textColor: addRangeTextColor);
                                        addRange = 1;
                                        widget.dates!.add(firstRangeDate!);
                                      } else {
                                        if (firstRangeDate!.date != date) {
                                          addRange = 0;
                                          if (firstRangeDate!.date
                                              .isAfter(date)) {
                                            DateTime switcher =
                                                firstRangeDate!.date;
                                            firstRangeDate!.date = date;
                                            date = switcher;
                                          }
                                          widget.dates!.remove(firstRangeDate!);
                                          widget.ranges!.add(RangeDate(
                                              start: firstRangeDate!.date,
                                              end: date));
                                        }
                                      }
                                    } else if (widget.calendarType ==
                                        CustomCalendarType.multiDates) {
                                      addDatesLogic(
                                        foundDate: foundDate,
                                        foundRange: foundRange,
                                        date: date,
                                      );
                                    } else if (widget.calendarType ==
                                        CustomCalendarType.multiRanges) {
                                      addRangesLogic(
                                        foundDate: foundDate,
                                        foundRange: foundRange,
                                        date: date,
                                      );
                                    } else if (widget.calendarType ==
                                        CustomCalendarType
                                            .multiDatesAndRanges) {
                                      if (addDates != -1) {
                                        if (addDates == 0) {
                                          addDatesLogic(
                                            foundDate: foundDate,
                                            foundRange: foundRange,
                                            date: date,
                                          );
                                        } else {
                                          addRangesLogic(
                                            foundDate: foundDate,
                                            foundRange: foundRange,
                                            date: date,
                                          );
                                        }
                                      }
                                    }
                                  });
                                }
                              },
                              child: dateDayWidget(
                                inRange,
                                index,
                                extraDays,
                                dateIndex,
                              ),
                            );
                    } else {
                      count--;
                      return const SizedBox();
                    }
                  },
                  itemCount: daysInMonth + extraDays,
                ),
              ),
            ),
            if (widget.calendarType == CustomCalendarType.multiDatesAndRanges)
              Padding(
                padding: edge(padding: widget.addDatesMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    addDatesItem(
                        text: widget.local == 'en' ? 'Add Days' : 'أضف أيام',
                        color: addDates == 0
                            ? widget.addDatesIndicatorActiveColor
                            : widget.addDatesIndicatorColor,
                        textStyle: addDates == 0
                            ? widget.addDatesActiveTextStyle
                            : widget.addDatesTextStyle,
                        onTap: () {
                          setState(() {
                            addDates = 0;
                            dateColor = 0;
                            defaultShowDialog(
                              context: context,
                            );
                          });
                        }),
                    addDatesItem(
                        text:
                            widget.local == 'en' ? 'Add Ranges' : 'أضف نطاقات',
                        color: addDates == 1
                            ? widget.addDatesIndicatorActiveColor
                            : widget.addDatesIndicatorColor,
                        textStyle: addDates == 1
                            ? widget.addDatesActiveTextStyle
                            : widget.addDatesTextStyle,
                        onTap: () {
                          setState(() {
                            addDates = 1;
                            dateColor = 0;
                            defaultShowDialog(
                              context: context,
                            );
                          });
                        }),
                  ],
                ),
              ),
          ],
        ),
        AnimatedContainer(
          duration: widget.yearDuration,
          margin: edge(
              padding: EdgeInsets.only(
            left: widget.local == 'en' ? 110 : 75,
            top: 35,
          )),
          height: showYears ? 240 : 0,
          width: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 0),
                blurRadius: 5,
                color: Colors.black12,
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(61, (index) {
                countYears++;
                int year = DateTime.now().year + countYears;
                return Padding(
                  padding:
                      edge(padding: const EdgeInsets.only(top: 5, bottom: 5)),
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        currentDate = DateTime(year, currentDate.month, 1);
                        showYears = false;
                      });
                    },
                    child: Text(
                      widget.local == 'en'
                          ? '${DateTime.now().year + countYears}'
                          : convertToArOrEnNumerals(
                              '${DateTime.now().year + countYears}'),
                      style: ((DateTime.now().year + countYears) ==
                              currentDate.year)
                          ? widget.dropDownYearsStyle
                              .copyWith(color: Colors.blue)
                          : widget.dropDownYearsStyle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  InkWell addDatesItem({
    required String text,
    required Color color,
    required TextStyle textStyle,
    required Function() onTap,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: color,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  void addDatesLogic({
    required int foundDate,
    required int foundRange,
    required DateTime date,
  }) {
    if (foundRange != -1) {
      widget.ranges!.remove(widget.ranges![foundRange]);
    } else if (foundDate != -1) {
      widget.dates!.remove(widget.dates![foundDate]);
    } else {
      widget.dates!.add(Date(
        date: date,
        color: addDayColor,
        textColor: addDayTextColor,
      ));
    }
    if (widget.onDatesUpdated != null) {
      widget.onDatesUpdated!(widget.dates!);
    }
  }

  void addRangesLogic({
    required int foundDate,
    required int foundRange,
    required DateTime date,
  }) {
    if (foundDate != -1) {
      widget.dates!.remove(widget.dates![foundDate]);
    }
    if (foundRange != -1) {
      widget.ranges!.remove(widget.ranges![foundRange]);
    } else {
      if (addRange == 0) {
        firstRangeDate = Date(
            date: date, color: addRangeColor, textColor: addRangeTextColor);
        addRange = 1;
        widget.dates!.add(firstRangeDate!);
      } else {
        addRange = 0;
        if (firstRangeDate!.date.isAfter(date)) {
          DateTime switcher = firstRangeDate!.date;
          firstRangeDate!.date = date;
          date = switcher;
        }
        widget.dates!.removeWhere((element) =>
            (DateTime(firstRangeDate!.date.year, firstRangeDate!.date.month,
                    firstRangeDate!.date.day) ==
                element.date) ||
            (DateTime(date.year, date.month, date.day) == element.date) ||
            (DateTime(firstRangeDate!.date.year, firstRangeDate!.date.month,
                        firstRangeDate!.date.day)
                    .isBefore(element.date) &&
                DateTime(date.year, date.month, date.day)
                    .isAfter(element.date)));
        widget.ranges!.removeWhere((element) =>
            (firstRangeDate!.date.isBefore(element.start) ||
                firstRangeDate!.date == element.start) &&
            (date.isAfter(element.end) || date == element.end));
        widget.ranges!.add(RangeDate(
            start: firstRangeDate!.date,
            end: date,
            color: addRangeColor,
            textColor: addRangeTextColor));
      }
    }
    if (widget.onRangesUpdated != null) {
      widget.onRangesUpdated!(widget.ranges!);
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'models/range_model.dart';

class CustomCalendarViewer extends StatefulWidget {

  /// - Here you can add specific active days dates
  final List<DateTime>? dates;
  /// - Here you can add specific active ranges dates
  final List<RangeDate>? ranges;


  /// - Here you can add the active days colors make sure if you used this, this should have the same dates length
  ///
  /// - Note if you didn't use datesColors or rangesColor the widget will use activeColor
  final List<Color>? datesColors;
  /// - Here you can add the active ranges colors make sure if you used this, this should have the same ranges length
  ///
  /// - Note if you didn't use datesColors or rangesColor the widget will use activeColor
  final List<Color>? rangesColors;


  /// - Here you can add the active days text colors make sure if you used this, this should have the same dates length
  ///
  /// - Note if you didn't use datesTextColors or rangeTextColors the widget will use the color in activeDayNumStyle
  final List<Color>? datesTextColors;
  /// - Here you can add the active ranges text colors make sure if you used this, this should have the same ranges length
  ///
  /// - Note if you didn't use datesTextColors or rangeTextColors the widget will use the color in activeDayNumStyle
  final List<Color>? rangeTextColors;


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


  /// - With these you can handel the margin left for the header
  final double headerMarginLeft;


  /// - With these you can handel the margin right for the header
  final double headerMarginRight;


  /// - With these you can handel the margin top for the header
  final double headerMarginTop;


  /// - With these you can handel the margin bottom for the header
  final double headerMarginBottom;


  /// - With these you can handel the margin left for the body
  final double daysMarginLeft;


  /// - With these you can handel the margin right for the body
  final double daysMarginRight;


  /// - With these you can handel the margin top for the body
  final double daysMarginTop;


  /// - With these you can handel the margin bottom for the body
  final double daysMarginBottom;

   const CustomCalendarViewer({
    super.key,
    this.duration = const Duration(milliseconds: 600),
    this.yearDuration = const Duration(milliseconds: 500),
    this.dates,
    this.ranges,
    this.datesColors,
    this.rangesColors,
     this.datesTextColors,
     this.rangeTextColors,
    this.activeColor = Colors.blue,
    this.dropArrowColor = Colors.black,
    this.movingArrowColor = Colors.black,
    this.currentDayBorder,
    this.dayBorder,
    this.headerBackground = Colors.transparent,
    this.daysHeaderBackground = Colors.transparent,
    this.daysBodyBackground = Colors.transparent,
    this.showCurrentDayBorder = true,
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
    this.headerMarginLeft = 42,
    this.headerMarginRight = 42,
    this.headerMarginTop = 8,
    this.headerMarginBottom = 10,
    this.daysMarginLeft = 45,
    this.daysMarginRight = 45,
    this.daysMarginTop = 0,
    this.daysMarginBottom = 0,
    this.local = 'en',
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
      double left = 0,
      double right = 0,
      double top = 0,
      double bottom = 0,
    }) {
      return widget.local == 'en'
          ? EdgeInsets.only(
              left: left,
              right: right,
              top: top,
              bottom: bottom,
            )
          : EdgeInsets.only(
              left: right,
              right: left,
              top: top,
              bottom: bottom,
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

    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: edge(left: widget.headerMarginLeft, right: widget.headerMarginRight, top: widget.headerMarginTop, bottom: widget.headerMarginBottom),
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
                        padding: edge(left: 10, right: 5),
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
                          colorFilter: ColorFilter.mode(widget.movingArrowColor, BlendMode.srcIn),
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
                          colorFilter: ColorFilter.mode(widget.movingArrowColor, BlendMode.srcIn),
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
              margin: edge(left: widget.daysMarginLeft, right: widget.daysMarginRight, top: widget.daysMarginTop, bottom: widget.daysMarginBottom),
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
                margin: edge(left: widget.daysMarginLeft, right: widget.daysMarginRight, top: widget.daysMarginTop, bottom: widget.daysMarginBottom),
                height:
                    (extraDays == 6 || (extraDays == 5 && daysInMonth == 31))
                        ? 285
                        : 240,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7),
                  itemBuilder: (_, index) {
                    if (count == 0) {
                      int dateIndex = widget.dates == null
                          ? -1
                          : widget.dates!.indexWhere((date) =>
                              date.year == currentDate.year &&
                              date.month == currentDate.month &&
                              date.day == ((index + 1) - extraDays));
                      List inRange = checkInRange(DateTime(currentDate.year,
                          currentDate.month, (index + 1) - extraDays));
                      return SlideTransition(
                        position: _offsetAnimation,
                        child: Container(
                          alignment: Alignment.center,
                          margin: inRange[0] == -1
                              ? edge(left: 1, right: 1, top: 1, bottom: 1)
                              : inRange[1] == 'start'
                                  ? edge(left: 1, top: 1, bottom: 1)
                                  : inRange[1] == 'end'
                                      ? edge(right: 1, top: 1, bottom: 1)
                                      : edge(top: 1, bottom: 1),
                          decoration: BoxDecoration(
                            borderRadius: inRange[0] == -1
                                ? BorderRadius.circular(widget.radius)
                                : inRange[1] == 'start'
                                    ? (widget.local == 'en'
                                        ?  BorderRadius.only(
                                            topLeft: Radius.circular(widget.radius),
                                            bottomLeft: Radius.circular(widget.radius))
                                        :  BorderRadius.only(
                                            topRight: Radius.circular(widget.radius),
                                            bottomRight: Radius.circular(widget.radius)))
                                    : inRange[1] == 'end'
                                        ? (widget.local == 'en'
                                            ?  BorderRadius.only(
                                                topRight: Radius.circular(widget.radius),
                                                bottomRight:
                                                    Radius.circular(widget.radius))
                                            :  BorderRadius.only(
                                                topLeft: Radius.circular(widget.radius),
                                                bottomLeft:
                                                    Radius.circular(widget.radius)))
                                        : BorderRadius.zero,
                            border: (DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day) ==
                                        DateTime(
                                            currentDate.year,
                                            currentDate.month,
                                            (index + 1) - extraDays) &&
                                    widget.showCurrentDayBorder)
                                ? widget.currentDayBorder?? Border.all(color: Colors.blue)
                                : widget.dayBorder,
                            color: inRange[0] == -1
                                ? (dateIndex != -1
                                    ? widget.datesColors == null
                                        ? widget.activeColor
                                        : widget.datesColors![dateIndex]
                                    : Colors.transparent)
                                : widget.rangesColors == null
                                    ? widget.activeColor
                                    : widget.rangesColors![inRange[0]],
                          ),
                          child: Text(
                            widget.local == 'en'
                                ? '${(index + 1) - extraDays}'
                                : convertToArOrEnNumerals(
                                    '${(index + 1) - extraDays}'),
                            style: (dateIndex != -1 || inRange[0] != -1)
                                ? ((widget.datesTextColors != null)?
                            widget.activeDayNumStyle.copyWith(
                              color: inRange[0] == -1? widget.datesTextColors![dateIndex] : widget.rangeTextColors![inRange[0]],
                            ) :widget.activeDayNumStyle)
                                : widget.dayNumStyle,
                          ),
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
          ],
        ),
        AnimatedContainer(
          duration: widget.yearDuration,
          margin: edge(
            left: 110,
            top: 35,
          ),
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
                  padding: edge(top: 5, bottom: 5),
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
}

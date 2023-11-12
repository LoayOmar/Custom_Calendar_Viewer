import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'models/range_model.dart';

class CustomCalendarViewer extends StatefulWidget {
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

  const CustomCalendarViewer({
    super.key,
    this.dates,
    this.ranges,
    this.datesColors,
    this.rangesColors,
    this.activeColor = Colors.blue,
    this.dropArrowColor = Colors.black,
    this.movingArrowColor = Colors.black,
    this.currentDayBorderColor = Colors.blue,
    this.showCurrentDayBorderColor = true,
    this.dropArrowSize = 34,
    this.movingArrowSize = 16,
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
      duration: const Duration(milliseconds: 1000),
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
        Future.delayed(const Duration(milliseconds: 1000)).then((value) {
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
        Future.delayed(const Duration(milliseconds: 1000)).then((value) {
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
            Padding(
              padding: edge(left: 42, right: 42, top: 8, bottom: 10),
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
                          color: widget.movingArrowColor,
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
                          color: widget.movingArrowColor,
                          width: widget.movingArrowSize,
                          height: widget.movingArrowSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: GridView.builder(
                padding: edge(left: 45, right: 45),
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
              child: SizedBox(
                height:
                    (extraDays == 6 || (extraDays == 5 && daysInMonth == 31))
                        ? 285
                        : 240,
                child: GridView.builder(
                  padding: edge(left: 45, right: 45),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                ? BorderRadius.circular(40)
                                : inRange[1] == 'start'
                                    ? (widget.local == 'en'
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            bottomLeft: Radius.circular(40))
                                        : const BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(40)))
                                    : inRange[1] == 'end'
                                        ? (widget.local == 'en'
                                            ? const BorderRadius.only(
                                                topRight: Radius.circular(40),
                                                bottomRight:
                                                    Radius.circular(40))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                bottomLeft:
                                                    Radius.circular(40)))
                                        : BorderRadius.zero,
                            border: (DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day) ==
                                        DateTime(
                                            currentDate.year,
                                            currentDate.month,
                                            (index + 1) - extraDays) &&
                                    widget.showCurrentDayBorderColor)
                                ? Border.all(
                                    color: widget.currentDayBorderColor)
                                : null,
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
                                ? widget.activeDayNumStyle
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
          duration: const Duration(milliseconds: 500),
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

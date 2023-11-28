import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'models/date_model.dart';
import 'models/range_model.dart';

enum CustomCalendarType {
  view,
  date,
  range,
  multiDates,
  multiRanges,
  multiDatesAndRanges,
  monthsAndYears
}

enum CustomCalendarStyle {
  withBorder,
  normal,
}

enum CustomCalendarStartDay {
  saturday,
  sunday,
  monday,
}

List<Date>? dates;
List<RangeDate>? ranges;
DateTime currentDate = DateTime.now();

class CustomCalendarViewer extends StatefulWidget {
  /// - Here you can add specific active days dates
  /// - This  will take Date Model
  /// - if you leave the color or text color null this will take the colors from active color for background and active day num style for text color
  final List<Date>? dates;

  /// - Here you can add specific active ranges dates
  /// - This  will take RangeDate Model
  /// - if you leave the color or text color null this will take the colors from active color for background and active day num style for text color
  final List<RangeDate>? ranges;

  /// - If you need to put specific color for each day name
  /// - Make sure the list should have 7 colors when used
  final List<Color>? daysNameColors;

  /// - This function will give you the date for the day that's tapped
  final Function(DateTime date)? onDayTapped;

  /// - This function will give you the new date when the month or year updated
  final Function(DateTime date)? onCalendarUpdate;

  /// - This function will give you the updated lest for dates
  final Function(List<Date>)? onDatesUpdated;

  /// - This function will give you the updated lest for dates
  final Function(List<RangeDate>)? onRangesUpdated;

  /// - There's 6 types to handle your calendar
  ///   - CustomCalendarType.view this will make the user can't press on the calendar just for view
  ///   - CustomCalendarType.date this will make the user can add only one date
  ///   - CustomCalendarType.range this will make the user to add only one range
  ///   - CustomCalendarType.multiDates this will make the user can add multiple dates
  ///   - CustomCalendarType.multiRanges this will make the user can add multiple ranges
  ///   - CustomCalendarType.multiDatesAndRanges this will make the user can add multiple dates and ranges
  ///   - CustomCalendarType.monthsAndYears this will make you can show calendar with only years and months
  final CustomCalendarType calendarType;

  /// - There's 2 style to handle your calendar
  ///   - CustomCalendarStyle.withBorder this will add border around the calendar
  ///   - CustomCalendarStyle.normal this will show the calendar without border
  final CustomCalendarStyle calendarStyle;

  /// - From here you can change the start day there's 3 types
  ///   - CustomCalendarStyle.saturday
  ///   - CustomCalendarStyle.sunday
  ///   - CustomCalendarStyle.monday
  final CustomCalendarStartDay calendarStartDay;

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

  /// - If You need to show border between days name and the days number
  final bool showBorderAfterDayHeader;

  /// - If this true the header will be shown
  final bool showHeader;

  /// - If this true the header will be shown only with Month and Year
  final bool showMonthAndYearHeader;

  /// - Put the alignment for Header
  final MainAxisAlignment headerAlignment;

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
  final TextStyle inActiveStyle;

  /// - From these you can handel the style for active day number text in the calendar
  final TextStyle activeStyle;

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

  /// - The alignment for the icon default in Alignment.topLeft
  /// - The icon widget this will shown with the day number
  final Alignment iconAlignment;

  /// - The space around the icon
  /// - The icon widget this will shown with the day number
  final EdgeInsets iconPadding;

  /// - The color for the border around the calendar
  final Color calendarBorderColor;

  /// - The radius for the border around the calendar
  final double calendarBorderRadius;

  /// - The width for the border around the calendar
  final double calendarBorderWidth;

  /// - If you need to close dates before specific date just enter this here
  final DateTime? closeDateBefore;

  /// - Here if you need to put specific color for closed date
  final Color closedDatesColor;

  // - ToolTip Style

  /// - The text to display in the tooltip. Only one of message.
  final String toolTipMessage;

  /// - The height of the tooltip's child.
  /// - If the child is null, then this is the tooltip's intrinsic height.
  final double? toolTipHeight;

  /// - If you need to add space to toolTip from left side
  final double toolTipAddSpaceLeft;

  /// - If you need to add space to toolTip from top
  final double toolTipAddSpaceTop;

  /// - The amount of space by which to inset the tooltip's child.
  /// - On mobile, defaults to 16.0 logical pixels horizontally and 4.0 vertically.
  /// - On desktop, defaults to 8.0 logical pixels horizontally and 4.0 vertically.
  final EdgeInsets? toolTipPadding;

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
  final Duration toolTipWaitDuration;

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
    this.daysNameColors,
    this.onDayTapped,
    this.onCalendarUpdate,
    this.onDatesUpdated,
    this.onRangesUpdated,
    this.calendarType = CustomCalendarType.view,
    this.calendarStyle = CustomCalendarStyle.withBorder,
    this.calendarStartDay = CustomCalendarStartDay.monday,
    this.activeColor = Colors.blue,
    this.dropArrowColor = Colors.black,
    this.movingArrowColor = Colors.black,
    this.currentDayBorder,
    this.dayBorder,
    this.headerBackground = Colors.transparent,
    this.daysHeaderBackground = Colors.transparent,
    this.daysBodyBackground = Colors.transparent,
    this.showCurrentDayBorder = true,
    this.showBorderAfterDayHeader = false,
    this.showMonthAndYearHeader = false,
    this.headerAlignment = MainAxisAlignment.spaceBetween,
    this.showHeader = true,
    this.dropArrowSize = 34,
    this.movingArrowSize = 16,
    this.closeDateBefore,
    this.closedDatesColor = Colors.grey,
    this.radius = 40,
    this.headerStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    this.dropDownYearsStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    this.dayNameStyle = const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
    this.inActiveStyle = const TextStyle(
        fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
    this.activeStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.white,
    ),
    this.headerMargin =
        const EdgeInsets.only(left: 42, right: 42, top: 8, bottom: 10),
    this.daysMargin =
        const EdgeInsets.only(left: 45, right: 45, top: 0, bottom: 0),
    this.iconAlignment = Alignment.topLeft,
    this.iconPadding = EdgeInsets.zero,
    this.calendarBorderColor = Colors.grey,
    this.calendarBorderRadius = 10,
    this.calendarBorderWidth = 1,
    this.local = 'en',
    this.toolTipMessage = 'Message',
    this.toolTipHeight,
    this.toolTipAddSpaceLeft = 10,
    this.toolTipAddSpaceTop = 15,
    this.toolTipPadding,
    this.toolTipDecoration,
    this.toolTipTextStyle,
    this.toolTipTextAlign,
    this.toolTipWaitDuration = const Duration(seconds: 2),
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
List<String> days = [];
List<String> arDays = [];
class _CustomCalendarViewerState extends State<CustomCalendarViewer>
    with SingleTickerProviderStateMixin {
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
  final List<String> monthsEn = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
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
  OverlayEntry? overlayEntry;
  bool showOverlay = false;
  Timer? timer;
  List<GlobalKey> widgetKey = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    dates = widget.dates ?? [];
    ranges = widget.ranges ?? [];
    _offsetAnimation = _offsetTween.animate(_controller);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
    if(widget.calendarStartDay == CustomCalendarStartDay.monday){
      days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
      arDays = ['أ', 'ث', 'أ', 'خ', 'ج', 'س', 'ح'];
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
    }else if(widget.calendarStartDay == CustomCalendarStartDay.sunday){
      days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
      arDays = ['ح', 'أ', 'ث', 'أ', 'خ', 'ج', 'س'];
      if (firstDay == 'Sun') {
        extraDays = 0;
      }else if (firstDay == 'Mon') {
        extraDays = 1;
      } else if (firstDay == 'Tue') {
        extraDays = 2;
      } else if (firstDay == 'Wed') {
        extraDays = 3;
      } else if (firstDay == 'Thu') {
        extraDays = 4;
      } else if (firstDay == 'Fri') {
        extraDays = 5;
      } else if (firstDay == 'Sat') {
        extraDays = 6;
      }
    }else if(widget.calendarStartDay == CustomCalendarStartDay.saturday){
      days = ['S', 'S', 'M', 'T', 'W', 'T', 'F'];
      arDays = ['س', 'ح', 'أ', 'ث', 'أ', 'خ', 'ج'];
      if (firstDay == 'Sat') {
        extraDays = 0;
      }else if (firstDay == 'Sun') {
        extraDays = 1;
      }else if (firstDay == 'Mon') {
        extraDays = 2;
      } else if (firstDay == 'Tue') {
        extraDays = 3;
      } else if (firstDay == 'Wed') {
        extraDays = 4;
      } else if (firstDay == 'Thu') {
        extraDays = 5;
      } else if (firstDay == 'Fri') {
        extraDays = 6;
      }
    }

    int count = extraDays;
    int countYears = -31;


    void backArrow() {
      setState(() {
        triggerAnimation(toRight: widget.local == 'en' ? true : false);
        Future.delayed(widget.duration).then((value) {
          setState(() {
            if (widget.calendarType == CustomCalendarType.monthsAndYears) {
              currentDate =
                  DateTime(currentDate.year - 1, currentDate.month, 1);
              if (widget.onCalendarUpdate != null) {
                widget.onCalendarUpdate!(currentDate);
              }
            } else {
              addMonth--;
              currentDate =
                  DateTime(currentDate.year, currentDate.month - 1, 1);
              if (widget.onCalendarUpdate != null) {
                widget.onCalendarUpdate!(currentDate);
              }
            }
          });
        });
      });
    }

    void forwardArrow() {
      setState(() {
        triggerAnimation(toRight: widget.local == 'en' ? false : true);
        Future.delayed(widget.duration).then((value) {
          setState(() {
            if (widget.calendarType == CustomCalendarType.monthsAndYears) {
              currentDate =
                  DateTime(currentDate.year + 1, currentDate.month, 1);
              if (widget.onCalendarUpdate != null) {
                widget.onCalendarUpdate!(currentDate);
              }
            } else {
              addMonth++;
              currentDate =
                  DateTime(currentDate.year, currentDate.month + 1, 1);
              if (widget.onCalendarUpdate != null) {
                widget.onCalendarUpdate!(currentDate);
              }
            }
          });
        });
      });
    }

    void onDateTaped(int index) {
      if (widget.calendarType != CustomCalendarType.view) {
        setState(() {
          DateTime date = DateTime(
              currentDate.year, currentDate.month, index - extraDays + 1);
          if (widget.onDayTapped != null) {
            widget.onDayTapped!(date);
          }
          int foundDate = dates!.indexWhere(
            (element) =>
                DateTime(
                    element.date.year, element.date.month, element.date.day) ==
                date,
          );
          int foundRange = ranges!.indexWhere((element) => ((DateTime(
                      element.start.year,
                      element.start.month,
                      element.start.day) ==
                  date) ||
              (DateTime(element.end.year, element.end.month, element.end.day) ==
                  date) ||
              (DateTime(element.start.year, element.start.month,
                          element.start.day)
                      .isBefore(date) &&
                  DateTime(element.end.year, element.end.month, element.end.day)
                      .isAfter(date))));
          if (widget.calendarType == CustomCalendarType.date) {
            dates!.clear();
            dates!.add(Date(
              date: date,
            ));
            if (widget.onDatesUpdated != null) {
              widget.onDatesUpdated!(dates!);
            }
          } else if (widget.calendarType == CustomCalendarType.range) {
            if (addRange == 0) {
              ranges!.clear();
              firstRangeDate = Date(
                date: date,
              );
              addRange = 1;
              dates!.add(firstRangeDate!);
            } else {
              if (firstRangeDate!.date != date) {
                addRange = 0;
                if (firstRangeDate!.date.isAfter(date)) {
                  DateTime switcher = firstRangeDate!.date;
                  firstRangeDate!.date = date;
                  date = switcher;
                }
                dates!.remove(firstRangeDate!);
                ranges!.add(RangeDate(start: firstRangeDate!.date, end: date));
                if (widget.onRangesUpdated != null) {
                  widget.onRangesUpdated!(ranges!);
                }
              }
            }
          } else if (widget.calendarType == CustomCalendarType.multiDates) {
            addDatesLogic(
              foundDate: foundDate,
              foundRange: foundRange,
              date: date,
            );
          } else if (widget.calendarType == CustomCalendarType.multiRanges) {
            addRangesLogic(
              foundDate: foundDate,
              foundRange: foundRange,
              date: date,
            );
          } else if (widget.calendarType ==
              CustomCalendarType.multiDatesAndRanges) {
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
      } else {
        setState(() {
          DateTime date = DateTime(
              currentDate.year, currentDate.month, index - extraDays + 1);
          if (widget.onDayTapped != null) {
            widget.onDayTapped!(date);
          }
        });
      }
    }

    return Stack(
      children: [
        Column(
          children: [
            if (widget.showHeader || widget.showMonthAndYearHeader)
              buildHeader(month, year, backArrow, forwardArrow),
            if (widget.calendarType == CustomCalendarType.monthsAndYears)
              buildMonthAndYearsType(backArrow, forwardArrow),
            if (widget.calendarType != CustomCalendarType.monthsAndYears)
              buildCalendar(context, backArrow, forwardArrow, extraDays,
                  daysInMonth, count, onDateTaped),
            if (widget.calendarType == CustomCalendarType.multiDatesAndRanges)
              buildAddMultiDatesAndRanges(context),
          ],
        ),
        buildYearsCard(countYears),
      ],
    );
  }

  void addDatesLogic({
    required int foundDate,
    required int foundRange,
    required DateTime date,
  }) {
    if (foundRange != -1) {
      ranges!.remove(ranges![foundRange]);
    } else if (foundDate != -1) {
      dates!.remove(dates![foundDate]);
    } else {
      dates!.add(Date(
        date: date,
        color: widget.calendarType == CustomCalendarType.multiDates
            ? widget.activeColor
            : addDayColor,
        textColor: widget.calendarType == CustomCalendarType.multiRanges
            ? widget.activeStyle.color
            : addDayTextColor,
      ));
    }
    if (widget.onDatesUpdated != null) {
      widget.onDatesUpdated!(dates!);
    }
  }

  void addRangesLogic({
    required int foundDate,
    required int foundRange,
    required DateTime date,
  }) {
    if (foundDate != -1) {
      dates!.remove(dates![foundDate]);
    }
    if (foundRange != -1) {
      ranges!.remove(ranges![foundRange]);
    } else {
      if (addRange == 0) {
        if (foundDate == -1) {
          firstRangeDate = Date(
            date: date,
            color: widget.calendarType == CustomCalendarType.multiRanges
                ? widget.activeColor
                : addRangeColor,
            textColor: widget.calendarType == CustomCalendarType.multiRanges
                ? widget.activeStyle.color
                : addRangeTextColor,
          );
          addRange = 1;
          dates!.add(firstRangeDate!);
        }
      } else {
        addRange = 0;
        if (firstRangeDate!.date.isAfter(date)) {
          DateTime switcher = firstRangeDate!.date;
          firstRangeDate!.date = date;
          date = switcher;
        }
        dates!.removeWhere((element) =>
            (DateTime(firstRangeDate!.date.year, firstRangeDate!.date.month,
                    firstRangeDate!.date.day) ==
                element.date) ||
            (DateTime(date.year, date.month, date.day) == element.date) ||
            (DateTime(firstRangeDate!.date.year, firstRangeDate!.date.month,
                        firstRangeDate!.date.day)
                    .isBefore(element.date) &&
                DateTime(date.year, date.month, date.day)
                    .isAfter(element.date)));
        ranges!.removeWhere((element) =>
            (firstRangeDate!.date.isBefore(element.start) ||
                firstRangeDate!.date == element.start) &&
            (date.isAfter(element.end) || date == element.end));
        if (firstRangeDate!.date != date) {
          ranges!.add(RangeDate(
            start: firstRangeDate!.date,
            end: date,
            color: widget.calendarType == CustomCalendarType.multiRanges
                ? widget.activeColor
                : addRangeColor,
            textColor: widget.calendarType == CustomCalendarType.multiRanges
                ? widget.activeStyle.color
                : addRangeTextColor,
          ));
        } else {
          dates!.add(Date(
            date: date,
            color: widget.calendarType == CustomCalendarType.multiRanges
                ? widget.activeColor
                : addRangeColor,
            textColor: widget.calendarType == CustomCalendarType.multiRanges
                ? widget.activeStyle.color
                : addRangeTextColor,
          ));
        }
      }
    }
    if (widget.onRangesUpdated != null) {
      widget.onRangesUpdated!(ranges!);
    }
    if (widget.onDatesUpdated != null && addRange == 0) {
      widget.onDatesUpdated!(dates!);
    }
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

  List checkInRange(DateTime date) {
    for (int i = 0; i < ranges!.length; i++) {
      final range = ranges![i];
      DateTime start =
          DateTime(range.start.year, range.start.month, range.start.day);
      DateTime end = DateTime(range.end.year, range.end.month, range.end.day);

      if (start == end) {
        dates!.add(
            Date(date: start, color: range.color, textColor: range.textColor));
        ranges!.remove(range);
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

  void showOrHideOverlay(
    BuildContext context,
    int index,
    int extraDays,
    List<dynamic> inRange,
    int dateIndex,
  ) {
    setState(() {
      bool haveMessage = false;
      if (inRange[0] != -1) {
        if ((widget.local == 'en'
            ? ranges![inRange[0]].toolTipEnMessage.isNotEmpty
            : ranges![inRange[0]].toolTipEnMessage.isNotEmpty)) {
          haveMessage = true;
        }
      }
      if (dateIndex != -1) {
        if ((widget.local == 'en'
            ? dates![dateIndex].toolTipEnMessage.isNotEmpty
            : dates![dateIndex].toolTipEnMessage.isNotEmpty)) {
          haveMessage = true;
        }
      }
      if (haveMessage ||
          (inRange[0] == -1 &&
              dateIndex == -1 &&
              widget.toolTipMessage.isNotEmpty)) {
        if (showOverlay) {
          showOverlay = false;
          if (overlayEntry != null) {
            overlayEntry!.remove();
            overlayEntry = null;
          }
          timer?.cancel();
        } else {
          final OverlayState overlay = Overlay.of(context);
          showOverlay = true;

          final RenderBox? renderBox = widgetKey[index - extraDays]
              .currentContext
              ?.findRenderObject() as RenderBox?;

          if (renderBox != null) {
            final position = renderBox.localToGlobal(Offset.zero);

            overlayEntry = OverlayEntry(
              builder: (context) => Positioned(
                top: position.dy -
                    renderBox.size.height +
                    widget.toolTipAddSpaceTop,
                left: position.dx -
                    renderBox.size.width +
                    widget.toolTipAddSpaceLeft,
                child: Material(
                  color: Colors.transparent,
                  child: IntrinsicWidth(
                    child: Container(
                        height: widget.toolTipHeight,
                        padding: widget.toolTipPadding ??
                            edge(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5)),
                        decoration: widget.toolTipDecoration ??
                            BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                        child: Text(
                          (dateIndex == -1 && inRange[0] == -1)
                              ? widget.toolTipMessage
                              : inRange[0] != -1
                                  ? (widget.local == 'en'
                                      ? ranges![inRange[0]].toolTipEnMessage
                                      : ranges![inRange[0]].toolTipArMessage)
                                  : (widget.local == 'en'
                                      ? dates![dateIndex].toolTipEnMessage
                                      : dates![dateIndex].toolTipArMessage),
                          style: widget.toolTipTextStyle ??
                              const TextStyle(color: Colors.white),
                          textAlign: widget.toolTipTextAlign,
                        )),
                  ),
                ),
              ),
            );
          }

          overlay.insert(overlayEntry!);

          // Hide the overlay after a few seconds
          timer = Timer(widget.toolTipWaitDuration, () {
            if (mounted && showOverlay && overlayEntry != null) {
              showOverlay = false;
              overlayEntry!.remove();
              overlayEntry = null;
            }
          });
        }
      }
    });
  }

  //***************************************************************************************************************************************************************************************************************************************************************************************************//

  Widget buildHeader(
    String month,
    String year,
    void Function() backArrow,
    void Function() forwardArrow,
  ) {
    return Container(
      margin: edge(
        padding: widget.headerMargin,
      ),
      color: widget.headerBackground,
      child: Row(
        mainAxisAlignment: widget.headerAlignment,
        children: [
          if (widget.showHeader || widget.showMonthAndYearHeader)
            Row(
              children: [
                Text(
                  widget.local == 'en' ? month : monthsName[month]!,
                  style: widget.headerStyle,
                ),
                Padding(
                  padding:
                      edge(padding: const EdgeInsets.only(left: 10, right: 5)),
                  child: Text(
                    widget.local == 'en' ? year : convertToArOrEnNumerals(year),
                    style: widget.headerStyle,
                  ),
                ),
                if (widget.showHeader)
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
          if (widget.showHeader)
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
    );
  }

  Widget buildCalendar(
    BuildContext context,
    void Function() backArrow,
    void Function() forwardArrow,
    int extraDays,
    int daysInMonth,
    int count,
    void Function(int index) onDateTaped,
  ) {
    return Container(
      margin: edge(
        padding: widget.daysMargin,
      ),
      decoration: widget.calendarStyle == CustomCalendarStyle.withBorder
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.calendarBorderRadius),
              border: Border.all(
                color: widget.calendarBorderColor,
                width: widget.calendarBorderWidth,
              ),
            )
          : null,
      child: Column(
        children: [
          buildDayNames(),
          if (widget.calendarStyle == CustomCalendarStyle.withBorder ||
              widget.showBorderAfterDayHeader)
            Padding(
              padding: edge(
                  padding: EdgeInsets.only(
                      bottom: widget.showBorderAfterDayHeader ? 3 : 0)),
              child: Divider(
                color: widget.calendarBorderColor,
                thickness: widget.calendarBorderWidth,
              ),
            ),
          buildDayNumbers(context, backArrow, forwardArrow, extraDays,
              daysInMonth, count, onDateTaped),
        ],
      ),
    );
  }

  Widget buildDayNumbers(
    BuildContext context,
    void Function() backArrow,
    void Function() forwardArrow,
    int extraDays,
    int daysInMonth,
    int count,
    void Function(int index) onDateTaped,
  ) {
    widgetKey = [];
    for (int i = 0; i < 31; i++) {
      widgetKey.add(GlobalKey());
    }
    return GestureDetector(
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
        padding: widget.calendarStyle == CustomCalendarStyle.withBorder
            ? edge(padding: const EdgeInsets.all(3))
            : edge(padding: EdgeInsets.zero),
        height: (extraDays == 6 || (extraDays == 5 && daysInMonth == 31))
            ? 285
            : 240,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7),
          itemBuilder: (_, index) {
            if (count == 0) {
              int dateIndex = dates == null
                  ? -1
                  : dates!.indexWhere((Date date) =>
                      date.date.year == currentDate.year &&
                      date.date.month == currentDate.month &&
                      date.date.day == ((index + 1) - extraDays));
              List inRange = checkInRange(DateTime(currentDate.year,
                  currentDate.month, (index + 1) - extraDays));
              return widget.showTooltip
                  ? InkWell(
                      key: widgetKey[index - extraDays],
                      onTap: () {
                        onDateTaped(index);
                        if (showOverlay && overlayEntry != null) {
                          overlayEntry!.builder(context);
                        }
                        if (showOverlay) {
                          showOrHideOverlay(context, index, extraDays, inRange,
                              dateIndex); // Close the current tooltip
                          showOrHideOverlay(context, index, extraDays, inRange,
                              dateIndex); // Show the new tooltip immediately
                        } else {
                          showOrHideOverlay(context, index, extraDays, inRange,
                              dateIndex); // Show the tooltip
                        }
                      },
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
                        if (widget.closeDateBefore != null) {
                          if (DateTime(
                                      widget.closeDateBefore!.year,
                                      widget.closeDateBefore!.month,
                                      widget.closeDateBefore!.day)
                                  .isBefore(DateTime(
                                      currentDate.year,
                                      currentDate.month,
                                      (index + 1) - extraDays)) ||
                              DateTime(
                                      widget.closeDateBefore!.year,
                                      widget.closeDateBefore!.month,
                                      widget.closeDateBefore!.day) ==
                                  DateTime(currentDate.year, currentDate.month,
                                      (index + 1) - extraDays)) {
                            onDateTaped(index);
                          }
                        } else {
                          onDateTaped(index);
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
    );
  }

  Widget buildDayNames() {
    return Container(
      height: 40,
      color: widget.daysHeaderBackground,
      padding: widget.calendarStyle == CustomCalendarStyle.withBorder
          ? edge(padding: const EdgeInsets.all(3))
          : edge(padding: EdgeInsets.zero),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        itemBuilder: (_, index) => Align(
            alignment: Alignment.center,
            child: Text(
              widget.local == 'en' ? days[index] : arDays[index],
              style: widget.daysNameColors != null
                  ? widget.dayNameStyle.copyWith(
                      color: widget.daysNameColors![index],
                    )
                  : widget.dayNameStyle,
            )),
        itemCount: 7,
      ),
    );
  }

  Widget addDatesItem({
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

  Widget dateDayWidget(
    List<dynamic> inRange,
    int index,
    int extraDays,
    int dateIndex,
  ) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: inRange[0] == -1
                ? edge(
                    padding: const EdgeInsets.only(
                        left: 2, right: 2, top: 2, bottom: 2))
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
                      ? (dates == null || dates![dateIndex].color == null)
                          ? widget.activeColor
                          : dates![dateIndex].color
                      : Colors.transparent)
                  : (ranges == null || ranges![inRange[0]].color == null)
                      ? widget.activeColor
                      : ranges![inRange[0]].color,
            ),
            child: Text(
              widget.local == 'en'
                  ? '${(index + 1) - extraDays}'
                  : convertToArOrEnNumerals('${(index + 1) - extraDays}'),
              style: ((dateIndex != -1 || inRange[0] != -1)
                  ? ((dates != null || ranges != null)
                      ? widget.activeStyle.copyWith(
                          color: widget.closeDateBefore == null
                              ? (inRange[0] == -1
                                  ? (dates![dateIndex].textColor ??
                                      widget.activeStyle.color)
                                  : (ranges![inRange[0]].textColor ??
                                      widget.activeStyle.color))
                              : (DateTime(
                                          widget.closeDateBefore!.year,
                                          widget.closeDateBefore!.month,
                                          widget.closeDateBefore!.day)
                                      .isAfter(DateTime(
                                          currentDate.year,
                                          currentDate.month,
                                          (index + 1) - extraDays))
                                  ? widget.closedDatesColor
                                  : (inRange[0] == -1
                                      ? (dates![dateIndex].textColor ??
                                          widget.activeStyle.color)
                                      : (ranges![inRange[0]].textColor ??
                                          widget.activeStyle.color))),
                        )
                      : widget.activeStyle)
                  : widget.closeDateBefore == null
                      ? widget.inActiveStyle
                      : (DateTime(
                                  widget.closeDateBefore!.year,
                                  widget.closeDateBefore!.month,
                                  widget.closeDateBefore!.day)
                              .isAfter(DateTime(currentDate.year,
                                  currentDate.month, (index + 1) - extraDays))
                          ? widget.inActiveStyle
                              .copyWith(color: widget.closedDatesColor)
                          : widget.inActiveStyle)),
            ),
          ),
          Padding(
            padding: widget.iconPadding,
            child: Align(
              alignment: widget.iconAlignment,
              child: inRange[0] == -1
                  ? (dateIndex == -1 ? null : dates![dateIndex].icon)
                  : (inRange[1] == 'start' ? ranges![inRange[0]].icon : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMonthAndYearsType(
    void Function() backArrow,
    void Function() forwardArrow,
  ) {
    if (widget.dates != null) {
      setState(() {
        currentDate = widget.dates![0].date;
      });
    }
    return Container(
      margin: edge(
        padding: widget.daysMargin,
      ),
      decoration: widget.calendarStyle == CustomCalendarStyle.withBorder
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.calendarBorderRadius),
              border: Border.all(
                color: widget.calendarBorderColor,
                width: widget.calendarBorderWidth,
              ),
            )
          : null,
      child: Column(
        children: [
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
              padding: widget.calendarStyle == CustomCalendarStyle.withBorder
                  ? edge(padding: const EdgeInsets.all(3))
                  : edge(padding: EdgeInsets.zero),
              height: widget.calendarStyle == CustomCalendarStyle.withBorder
                  ? 260
                  : 255,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: 63),
                itemBuilder: (_, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        currentDate = DateTime(currentDate.year, index + 1, 1);
                        if (widget.onDayTapped != null) {
                          widget.onDayTapped!(currentDate);
                        }
                        dates!.clear();
                        dates!.add(Date(
                          date: DateTime(currentDate.year, index + 1, 1),
                        ));
                        if (widget.onDatesUpdated != null) {
                          widget.onDatesUpdated!(dates!);
                        }
                      });
                    },
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.radius),
                          color: DateTime(currentDate.year, index + 1, 1) ==
                                  DateTime(
                                      currentDate.year, currentDate.month, 1)
                              ? widget.activeColor
                              : Colors.transparent,
                        ),
                        child: Text(
                          widget.local == 'en'
                              ? monthsEn[index]
                              : monthsName[monthsEn[index]]!,
                          style: DateTime(currentDate.year, index + 1, 1) ==
                                  DateTime(
                                      currentDate.year, currentDate.month, 1)
                              ? widget.activeStyle
                              : widget.inActiveStyle,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 12,
              ),
            ),
          ),
        ],
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

  Widget buildYearsCard(int countYears) {
    return AnimatedContainer(
      duration: widget.yearDuration,
      margin: edge(
          padding: EdgeInsets.only(
        left: widget.local == 'en'
            ? widget.headerMargin.left + 70
            : widget.headerMargin.left + 35,
        top: 30 + widget.headerMargin.top,
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
              padding: edge(padding: const EdgeInsets.only(top: 5, bottom: 5)),
              child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    currentDate = DateTime(year, currentDate.month, 1);
                    showYears = false;
                    if (widget.onCalendarUpdate != null) {
                      widget.onCalendarUpdate!(currentDate);
                    }
                  });
                },
                child: Text(
                  widget.local == 'en'
                      ? '${DateTime.now().year + countYears}'
                      : convertToArOrEnNumerals(
                          '${DateTime.now().year + countYears}'),
                  style: ((DateTime.now().year + countYears) ==
                          currentDate.year)
                      ? widget.dropDownYearsStyle.copyWith(color: Colors.blue)
                      : widget.dropDownYearsStyle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildAddMultiDatesAndRanges(BuildContext context) {
    return Padding(
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
              text: widget.local == 'en' ? 'Add Ranges' : 'أضف نطاقات',
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
    );
  }
}

import 'package:custom_calendar_viewer/custom_calendar_viewer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calendar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String local = 'en';
  List<Date> dates = [
    Date(
      date: DateTime(DateTime.now().year, 1, 1),
      color: Colors.red,
      toolTipEnMessage: 'Date Message',
      toolTipArMessage: 'رسالة التاريخ',
    ),
    Date(
      date: DateTime(DateTime.now().year, 3, 1),
      color: Colors.red,
      toolTipEnMessage: 'Date Message',
      toolTipArMessage: 'رسالة التاريخ',
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 8),
      color: Colors.red,
      toolTipEnMessage: 'Date Message',
      toolTipArMessage: 'رسالة التاريخ',
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 10),
      color: Colors.amber,
      toolTipEnMessage: 'Date Message',
      toolTipArMessage: 'رسالة التاريخ',
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 7),
      color: Colors.amber,
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 1),
      color: Colors.red,
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 4),
      color: Colors.white,
      textColor: Colors.red,
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 5),
      color: Colors.white,
      textColor: Colors.red,
      icon: const Icon(
        Icons.add,
        size: 15,
      ),
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 18),
      color: Colors.blue,
      textColor: Colors.amber,
      icon: const Icon(
        Icons.add,
        size: 15,
        color: Colors.red,
      ),
    ),
    Date(
      date: DateTime(DateTime.now().year, 11, 22),
      icon: const Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: Colors.red,
          ),
          SizedBox(width: 5,),
          Icon(
            Icons.add,
            size: 15,
          ),
        ],
      ),
    ),
  ];
  List<RangeDate> ranges = [
    RangeDate(
      start: DateTime(DateTime.now().year, 11, 12),
      end: DateTime(DateTime.now().year, 11, 15),
      color: Colors.red,
      icon: const Icon(
        Icons.add,
        size: 15,
      ),
      toolTipEnMessage: 'Range Message',
      toolTipArMessage: 'رسالة المدي',
    ),
    RangeDate(
      start: DateTime(DateTime.now().year, 11, 24),
      end: DateTime(DateTime.now().year, 11, 27),
      color: Colors.amber,
      icon: const Icon(
        Icons.add,
        size: 15,
        color: Colors.red,
      ),
      toolTipEnMessage: 'Range Message',
      toolTipArMessage: 'رسالة المدي',
    ),
    RangeDate(
      start: DateTime(DateTime.now().year, 11, 30),
      end: DateTime(DateTime.now().year, 11, 29),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: local == 'en' ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Multi Dates And Ranges',
                    style: TextStyle(fontSize: 18),
                  ),
                  CustomCalendarViewer(
                    local: local,
                    dates: dates,
                    ranges: ranges,
                    calendarType: CustomCalendarType.multiDatesAndRanges,
                    calendarStyle: CustomCalendarStyle.normal,
                    animateDirection: CustomCalendarAnimatedDirection.vertical,
                    movingArrowSize: 24,
                    spaceBetweenMovingArrow: 20,
                    closeDateBefore: DateTime.now(),
                    closedDatesColor: Colors.grey.withOpacity(0.7),
                    //showHeader: false,
                    showBorderAfterDayHeader: true,
                    showTooltip: true,
                    toolTipMessage: '',
                    //headerAlignment: MainAxisAlignment.center,
                    calendarStartDay: CustomCalendarStartDay.monday,
                    onCalendarUpdate: (date) {
                      // Handel your code here.
                      print('onCalendarUpdate');
                      print(date);
                    },
                    onDayTapped: (date) {
                      // Handel your code here.
                      print('onDayTapped');
                      print(date);
                    },
                    onDatesUpdated: (newDates) {
                      print('onDatesUpdated');
                      print(newDates.length);
                    },
                    onRangesUpdated: (newRanges) {
                      print('onRangesUpdated');
                      print(newRanges.length);
                    },
                    //showCurrentDayBorder: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(),
                  ),
                  const Text(
                    'View Current Year',
                    style: TextStyle(fontSize: 18),
                  ),
                  CustomCalendarViewer(
                    local: local,
                    dates: dates,
                    ranges: ranges,
                    calendarType: CustomCalendarType.viewFullYear,
                    showHeader: false,
                    headerAlignment: MainAxisAlignment.center,
                    calendarStyle: CustomCalendarStyle.normal,
                    spaceBetweenMovingArrow: 20,
                    showBorderAfterDayHeader: true,
                    showTooltip: true,
                    toolTipMessage: '',
                    separatedWidget: const Divider(),
                    calendarStartDay: CustomCalendarStartDay.monday,
                    onCalendarUpdate: (date) {
                      // Handel your code here.
                      print('onCalendarUpdate');
                      print(date);
                    },
                    onDayTapped: (date) {
                      // Handel your code here.
                      print('onDayTapped');
                      print(date);
                    },
                    onDatesUpdated: (newDates) {
                      print('onDatesUpdated');
                      print(newDates.length);
                    },
                    onRangesUpdated: (newRanges) {
                      print('onRangesUpdated');
                      print(newRanges.length);
                    },
                    //showCurrentDayBorder: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
      textColor: Colors.amber,
    ),
    Date(
      date: DateTime(2023, 11, 22),
    ),
  ];
  List<RangeDate> ranges = [
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
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: local == 'en' ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: CustomCalendarViewer(
            local: local,
            dates: dates,
            ranges: ranges,
            calendarType: CustomCalendarType.multiDatesAndRanges,
            onDayTapped: (date) {
              // Handel your code here.
              print(date);
            },
            onDatesUpdated: (newDates) {
              print(newDates.length);
            },
            onRangesUpdated: (newRanges) {
              print(newRanges.length);
            },
            showCurrentDayBorder: false,
          ),
        ),
      ),
    );
  }
}

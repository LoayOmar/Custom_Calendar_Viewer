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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: CustomCalendarViewer(
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
      ),

    );
  }
}

import 'package:flutter/material.dart';

class RangeDate {
  DateTime start;
  DateTime end;
  Color? color;
  Color? textColor;
  Widget? icon;
  String toolTipArMessage;
  String toolTipEnMessage;

  RangeDate({
    required this.start,
    required this.end,
    this.color,
    this.textColor,
    this.icon,
    this.toolTipEnMessage = '',
    this.toolTipArMessage = '',
  });
}

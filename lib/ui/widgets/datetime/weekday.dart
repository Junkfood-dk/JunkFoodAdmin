// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chefapp/extensions/text_style_ext.dart';

class Weekday extends StatelessWidget {
  const Weekday({super.key, required this.date});

  final DateTime date;

  String localDate(DateTime date) {
    return DateFormat('EEEE').format(date).toString().toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Text(localDate(date),
        style: Theme.of(context).textTheme.titleMedium!.bold);
  }
}

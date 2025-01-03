// ignore_for_file: depend_on_referenced_packages

import 'package:chefapp/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DateSize { small, big }

class Date extends ConsumerWidget {
  const Date({super.key, required this.date, this.size = DateSize.big});
  const Date.small({super.key, required this.date}) : size = DateSize.small;

  final DateTime date;
  final DateSize size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormatter = ref.watch(Providers.dateFormatter);
    return size == DateSize.small
        ? Text(dateFormatter.format(date),
            style: Theme.of(context).textTheme.bodyMedium!)
        : Text(dateFormatter.format(date),
            style: Theme.of(context).textTheme.titleLarge!);
  }
}

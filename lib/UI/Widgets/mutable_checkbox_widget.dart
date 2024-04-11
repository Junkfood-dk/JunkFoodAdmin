import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MutableCheckboxWidget<T> extends ConsumerWidget {
  final AsyncValue<Map<dynamic, bool>> map;
  final void Function(String) postNew;
  final void Function(T) onSelected;
  final TextStyle labelStyle;
  final String labelText;
  final TextEditingController textController;
  const MutableCheckboxWidget(
      {super.key,
      required this.map,
      required this.onSelected,
      required this.labelText,
      required this.textController,
      required this.postNew,
      required this.labelStyle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Column(
            children: switch (map) {
          AsyncData(:final value) => value.entries.map((entry) {
              var key = entry.key;
              return CheckboxListTile(
                title: Text(key.name),
                value: value[key],
                onChanged: (bool? newValue) {
                  onSelected(key);
                },
              );
            }).toList(),
          _ => const [CircularProgressIndicator()]
        }),
        Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: labelStyle,
              ),
              controller: textController,
              onFieldSubmitted: (value) async {
                postNew(value);
                textController.clear();
              },
            ),
          ],
        ),
      ],
    );
  }
}

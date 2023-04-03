import 'package:flutter/material.dart';

class WdCheckbox extends StatelessWidget {
  const WdCheckbox(
      {required this.title,
      required this.value,
      required this.onChanged,
      super.key});
  final String title;
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).highlightColor,
    );
  }
}

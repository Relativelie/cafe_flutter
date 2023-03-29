import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Function(String) onSubmitted;
  final String? placeholder;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String? semanticIconLabel;

  const InputField({
    Key? key,
    required this.onSubmitted,
    this.placeholder,
    this.rightIcon,
    this.leftIcon,
    this.semanticIconLabel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        contentPadding: const EdgeInsets.all(2),
        hintText: placeholder,
        prefixIcon: (leftIcon != null)
            ? Icon(leftIcon,
                color: Theme.of(context).colorScheme.onPrimary,
                semanticLabel: semanticIconLabel)
            : null,
        suffixIcon: (rightIcon != null)
            ? Icon(rightIcon,
                color: Theme.of(context).colorScheme.onPrimary,
                semanticLabel: semanticIconLabel)
            : null,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

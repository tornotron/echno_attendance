import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final void Function()? onTap;

  const CustomDateField({
    super.key,
    required this.label,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          readOnly: true,
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.titleMedium,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}

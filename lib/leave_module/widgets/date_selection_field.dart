import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final void Function()? onTap;
  final FormFieldValidator<String>? validator;

  const CustomDateField({
    super.key,
    required this.label,
    this.controller,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.onTap,
    this.validator,
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
          controller: controller,
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
          validator: validator,
        ),
      ],
    );
  }
}

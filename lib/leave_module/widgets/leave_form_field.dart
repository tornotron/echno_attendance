import 'package:flutter/material.dart';

class LeaveFormField extends StatelessWidget {
  final String mainLabel;
  final bool? isEnabled;
  final bool? isReadOnly;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onTap;

  final FormFieldValidator<String>? validator;

  const LeaveFormField({
    required this.mainLabel,
    this.isEnabled,
    this.isReadOnly,
    this.maxLines,
    this.minLines,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainLabel,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller,
          enabled: isEnabled ?? true,
          readOnly: isReadOnly ?? false,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: const OutlineInputBorder(),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          ),
          onTap: onTap,
          validator: validator,
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

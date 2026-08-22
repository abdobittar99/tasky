import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_size.dart';

class CustomTextFormfield extends StatelessWidget {
  const CustomTextFormfield({
    super.key,
    required this.controller,
    required this.titel,
    required this.hintText,
    this.maxLines,
    this.validate,
  });
  final String titel;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titel, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: AppSize.h8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          validator: validate,
          style: Theme.of(context).textTheme.labelMedium,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

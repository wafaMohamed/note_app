import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.onChanged,
      required this.label});

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        controller: controller,
        style: textStyle,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: textStyle?.copyWith(
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

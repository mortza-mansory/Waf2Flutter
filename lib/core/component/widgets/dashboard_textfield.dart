import 'package:flutter/material.dart';
import 'package:msf/core/utills/colorconfig.dart';

class DashboardTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final int maxLength;
  final Function(String)? onChanged;
  const DashboardTextfield({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.onChanged,
    this.maxLength = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLength: maxLength,
      onChanged: (value) => onChanged!(value),
      style: const TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white30,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}

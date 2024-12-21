import 'package:flutter/material.dart';
import 'package:msf/utills/colorconfig.dart';

class DashboardTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final int maxLength;
  const DashboardTextfield({
    super.key,
    required this.textEditingController,
    this.hintText,
    this.maxLength = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLength: maxLength,
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
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}

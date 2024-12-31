import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String title;
  final Color? backgrounColor;
  final Color? titleColor;
  const StatusWidget(
      {super.key,
      required this.title,
      this.backgrounColor = Colors.greenAccent,
      this.titleColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgrounColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            color: titleColor,
          ),
        ),
      ),
    );
  }
}

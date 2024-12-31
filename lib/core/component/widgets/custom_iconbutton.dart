import 'package:flutter/material.dart';

class CustomIconbuttonWidget extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Color backColor;
  final Color? iconColor;
  final Color? titleColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  const CustomIconbuttonWidget({
    super.key,
    this.icon,
    this.title,
    required this.backColor,
    this.iconColor = Colors.white,
    this.titleColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 25,
        padding: padding,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: iconColor,
                    size: 15,
                  )
                : const SizedBox.shrink(),
            title != null
                ? Text(
                    title!,
                    style: TextStyle(color: titleColor, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

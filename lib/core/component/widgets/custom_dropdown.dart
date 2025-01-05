import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<dynamic> list;
  final dynamic value;
  final Function(dynamic) onchangeValue;
  const CustomDropdownWidget({
    Key? key,
    required this.list,
    required this.value,
    required this.onchangeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<dynamic>(
        value: value.toString(),
        onChanged: (value) {},
        items: list
            .map<DropdownMenuItem<dynamic>>(
                (dynamic value) => DropdownMenuItem<dynamic>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    ))
            .toList(),
        underline: SizedBox(),
      ),
    );
  }
}

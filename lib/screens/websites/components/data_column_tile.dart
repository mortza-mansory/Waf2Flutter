import 'package:flutter/material.dart';

class DataColumnTile {
  static DataColumn buildRow({
    required String title,
  }) {
    return DataColumn(
      label: Expanded(
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

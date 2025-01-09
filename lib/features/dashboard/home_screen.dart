import 'package:flutter/material.dart';
import 'package:msf/core/component/page_builder.dart';

import 'sections/Dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Dashboard(),
      ],
    );
  }
}

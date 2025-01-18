import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/dashboard/dashboard_screen.dart';
import 'package:msf/core/component/page_builder.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<IdleController>().onUserInteraction();
      },
      child: PageBuilder(
        sectionWidgets: [
          DashboardScreen(),
        ],
      ),
    );
  }
}

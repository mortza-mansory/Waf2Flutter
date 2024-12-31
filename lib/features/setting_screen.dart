import 'package:flutter/material.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/websites/websites_screen.dart';
import 'package:msf/core/utills/responsive.dart';
import 'controllers/settings/MenuController.dart';
import '../core/component/SideBar.dart';
import 'package:get/get.dart';

class Settingscreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();

  Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<IdleController>().onUserInteraction();
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: !Responsive.isDesktop(context)
            ? const Drawer(
                child: SideBar(),
              )
            : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),
            const Expanded(
              flex: 5,
              child: WebsitesScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

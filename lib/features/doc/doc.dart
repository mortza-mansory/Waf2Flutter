import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/doc/screen/intro.dart';
import 'package:msf/core/utills/responsive.dart';
import 'components/sidebar.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';

class DocScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();

  DocScreen({super.key});

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
                Expanded(
                  flex: 5,
                  child: IntroScreen(scaffoldKey: scaffoldKey),
                ),
              ],
            )));
  }
}

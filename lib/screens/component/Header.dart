import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:msf/controllers/dashboard/CounterController.dart';
import 'package:msf/utills/colorconfig.dart';
import 'package:msf/utills/responsive.dart';
import 'package:msf/controllers/settings/MenuController.dart';

class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Menu_Controller menuController = Get.find<Menu_Controller>();

  Header({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: () {
              menuController.openDrawer(scaffoldKey);
            },
            icon: const Icon(Icons.menu_sharp),
          ),
        if (!Responsive.isMobile(context))
          AutoSizeText(
            "Welcome Admin!".tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 1 : 2),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.toNamed("/doc");
          },
          child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: secondryColor),
              child: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.help),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "doc".tr,
                  ),
                ]),
              )),
        ),
        const SizedBox(width: 10),
        Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: secondryColor),
          child: Obx(
            () {
              return Center(
                child: Text(
                  "Time remaining:   ".tr + Get.find<Counter>().remainingSec,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        PopupMenuButton<String>(
          color: secondryColor,
          onSelected: (value) {
            if (value == 'logout'.tr) {
              _showLogoutConfirmation();
            }
          },
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'profile',
                child: Text('Profile'.tr),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'.tr),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'.tr),
              ),
            ];
          },
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: secondryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                AutoSizeText(
                  "test",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        backgroundColor: secondryColor,
        title: Text(
          "Logout".tr,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          "Are you sure you want to logout?".tr,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel".tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Confirm".tr),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}

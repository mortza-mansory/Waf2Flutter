import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:msf/core/router/app_router.dart';
import 'package:msf/features/controllers/settings/ThemeController.dart';
import 'package:msf/features/controllers/settings/TranslateController.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 80),
            Divider(color: Theme.of(context).dividerColor),
            ListTile(
              onTap: () {
                Get.toNamed("/home");
              },
              leading: const Icon(Icons.speed_outlined, color: Colors.white60),
              title: AutoSizeText(
                "Dashboard".tr,
                maxLines: 1,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            ExpansionPanelList.radio(
              initialOpenPanelValue: false,
              materialGapSize: 5,
              children: [
                ExpansionPanelRadio(
                  value: 0,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      leading: const Icon(Icons.web, color: Colors.white60),
                      title: Text("Websites".tr),
                    );
                  },
                  body: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Get.toNamed("/websites");
                        },
                        title: AutoSizeText(
                          "Websites".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed("/add_websites"),
                        leading: const Icon(Icons.add, color: Colors.white60),
                        title: AutoSizeText(
                          "Add Website".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionPanelRadio(
                  value: 1,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      leading: const Icon(Icons.build, color: Colors.white60),
                      title: Text("System".tr),
                    );
                  },
                  body: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () => Get.toNamed(AppRouter.manageNginxRoute),
                        leading: Icon(
                          Icons.rocket_launch,
                          size: 20,
                        ),
                        title: AutoSizeText(
                          "Manage Nginx".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(AppRouter.systemRoute),
                        leading: const Icon(
                          Icons.route,
                          color: Colors.white60,
                          size: 20,
                        ),
                        title: AutoSizeText(
                          "Routes".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () =>
                            Get.toNamed(AppRouter.activeConnectionRoute),
                        leading: const Icon(
                          Icons.connecting_airports_rounded,
                          color: Colors.white60,
                          size: 20,
                        ),
                        title: AutoSizeText(
                          "Active Connections".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      SizedBox(height: 5),
                      Divider(
                        color: Colors.black12,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      ListTile(
                        onTap: () =>
                            Get.toNamed(AppRouter.generalConfigurationRoute),
                        leading: const Icon(
                          Icons.build,
                          color: Colors.white60,
                          size: 20,
                        ),
                        title: AutoSizeText(
                          "General Configuration".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(AppRouter.userManagmentRoute),
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white60,
                          size: 20,
                        ),
                        title: AutoSizeText(
                          "Users".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(AppRouter.mediaRoute),
                        leading: const Icon(
                          Icons.star,
                          color: Colors.white60,
                          size: 20,
                        ),
                        title: AutoSizeText(
                          "Media".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionPanelRadio(
                  value: 2,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      leading: const Icon(Icons.public, color: Colors.white60),
                      title: Text("Interfaces".tr),
                    );
                  },
                  body: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          Get.toNamed(AppRouter.addVirtualipRoute);
                        },
                        leading: const Icon(Icons.add, color: Colors.white60),
                        title: AutoSizeText(
                          "Add virtual IP".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () =>
                            Get.toNamed(AppRouter.manageVirtualipRoute),
                        leading: const Icon(Icons.build, color: Colors.white60),
                        title: AutoSizeText(
                          "List Virtual IPs".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionPanelRadio(
                  value: 3,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      leading: const Icon(Icons.padding, color: Colors.white60),
                      title: Text("System Log".tr),
                    );
                  },
                  body: Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () => Get.toNamed(AppRouter.nginxLogRoute),
                        leading: const Icon(Icons.rocket_launch,
                            color: Colors.white60),
                        title: AutoSizeText(
                          "Nginx Log".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () => Get.toNamed(AppRouter.userActionLogRoute),
                        leading: const Icon(Icons.edit, color: Colors.white60),
                        title: AutoSizeText(
                          "User Actions Log".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      ListTile(
                        onTap: () =>
                            Get.toNamed(AppRouter.internalErrorLogRoute),
                        leading: const Icon(Icons.close, color: Colors.white60),
                        title: AutoSizeText(
                          "Internal Error Logs".tr,
                          maxLines: 1,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Get.toNamed("/setting");
              },
              leading: const Icon(Icons.settings_sharp, color: Colors.white60),
              title: AutoSizeText(
                "Settings".tr,
                maxLines: 1,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.speed_outlined, color: Colors.white60),
              title: AutoSizeText(
                "Statistics".tr,
                maxLines: 1,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AutoSizeText(
                    "Dark Mode".tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Obx(() {
                  return Switch(
                    value: Get.find<ThemeController>().isDark.value,
                    onChanged: (value) {
                      Get.find<ThemeController>().toggle();
                    },
                    activeColor: Theme.of(context).primaryColor,
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AutoSizeText(
                    "فارسی".tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Obx(() {
                  return Switch(
                    value: Get.find<TranslateController>().isEnglish.value,
                    onChanged: (value) {
                      Get.find<TranslateController>()
                          .changeLang(value ? 'en' : 'fa');
                    },
                    activeColor: Theme.of(context).primaryColor,
                  );
                }),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

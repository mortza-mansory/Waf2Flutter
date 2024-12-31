import 'package:flutter/material.dart';
import 'package:msf/core/bindings/bindings.dart';
import 'package:get/get.dart';
import 'package:msf/core/router/app_router.dart';
import 'package:msf/features/controllers/settings/ThemeController.dart';
import 'package:msf/features/home_screen.dart';
import 'package:msf/features/login/login_screen.dart';
import 'package:msf/features/setting_screen.dart';

import 'package:msf/features/doc/doc.dart';
import 'package:msf/features/login/OtpScreen.dart';
import 'package:msf/features/websites/add_website_screen.dart';
import 'package:msf/features/websites/websites_screen.dart';
import 'package:msf/core/services/unit/api/config/Config.dart';
import 'package:msf/core/utills/theme.dart';
import 'package:msf/core/utills/translator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.loadConfig();
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDark = Get.find<ThemeController>().isDark.value;

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Translator(),
        initialBinding: MyBindings(),
        getPages: AppRouter.appPages,
        navigatorObservers: [
          GetObserver((_) {
            print('User route: ${Get.currentRoute}');
          })
        ],
        initialRoute: AppRouter.loginRoute,
        title: 'ModSec Admin Panel'.tr,
        theme: getTheme(isDark),
      );
    });
  }
}

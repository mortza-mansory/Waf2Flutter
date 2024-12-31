import 'package:get/get.dart';
import 'package:msf/features/controllers/auth/CaptchaController.dart';
import 'package:msf/features/controllers/dashboard/CounterController.dart';
import 'package:msf/features/controllers/auth/LoginController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/features/controllers/settings/ThemeController.dart';
import 'package:msf/features/controllers/settings/TranslateController.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/dashboard/ResourceUsageController.dart';
import '../../features/controllers/ws/WsController.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => Menu_Controller());
    Get.put(Counter());
    Get.lazyPut(() => TranslateController());
    Get.put(IdleController());
    Get.lazyPut(() => ResourceUsageController());
    Get.put(WsController());
    Get.lazyPut(() => CaptchaController());
  }
}

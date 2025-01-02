import 'package:get/get.dart';
import 'package:msf/features/doc/doc.dart';
import 'package:msf/features/home_screen.dart';
import 'package:msf/features/login/OtpScreen.dart';
import 'package:msf/features/login/login_screen.dart';
import 'package:msf/features/setting_screen.dart';
import 'package:msf/features/websites/add_website_screen.dart';
import 'package:msf/features/websites/edit_webite.dart';
import 'package:msf/features/websites/website_log.dart';
import 'package:msf/features/websites/websites_screen.dart';

class AppRouter {
  static String loginRoute = "/login";
  static String homeRoute = "/home";
  static String websiteRoute = "/websites";
  static String addWebsiteRoute = '/add_websites';
  static String websiteLogRoute = '/log_websites';
  static String editWebsiteRoute = '/edit_websites';
  static String settingRoute = '/setting';
  static String otpRoute = '/otp';
  static String docRoute = '/doc';
  static final appPages = [
    GetPage(name: loginRoute, page: () => LoginScreen()),
    GetPage(name: homeRoute, page: () => HomeScreen()),
    GetPage(name: websiteRoute, page: () => const WebsitesScreen()),
    GetPage(name: addWebsiteRoute, page: () => const AddWebsiteScreen()),
    GetPage(name: websiteLogRoute, page: () => const WebsitesLogScreen()),
    GetPage(name: editWebsiteRoute, page: () => const EditWebsite()),
    GetPage(name: settingRoute, page: () => Settingscreen()),
    GetPage(name: otpRoute, page: () => OtpScreen()),
    GetPage(name: docRoute, page: () => DocScreen()),
  ];
}

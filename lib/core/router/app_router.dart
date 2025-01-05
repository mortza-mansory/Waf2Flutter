import 'package:get/get.dart';
import 'package:msf/features/doc/doc.dart';
import 'package:msf/features/home_screen.dart';
import 'package:msf/features/interface/add_virtualip_screen.dart';
import 'package:msf/features/interface/manage_virtualip_screen.dart';
import 'package:msf/features/login/otpscreen.dart';
import 'package:msf/features/login/login_screen.dart';
import 'package:msf/features/setting_screen.dart';
import 'package:msf/features/system/active_connections_screen.dart';
import 'package:msf/features/system/general_configuration_screen.dart';
import 'package:msf/features/system/manage_nginx_screen.dart';
import 'package:msf/features/system/media_screen.dart';
import 'package:msf/features/system/routes_screen.dart';
import 'package:msf/features/system/users/add_user_screen.dart';
import 'package:msf/features/system/users/user_managment_screen.dart';
import 'package:msf/features/system_log/internal_errorlog_screen.dart';
import 'package:msf/features/system_log/nginx_log_screen.dart';
import 'package:msf/features/system_log/user_actionlog_screen.dart';
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
  static String manageNginxRoute = '/manage_nginx';
  static String systemRoute = '/system_routes';
  static String activeConnectionRoute = '/active_connection';
  static String generalConfigurationRoute = '/general_confg';
  static String userManagmentRoute = '/user_management';
  static String addUserManagmentRoute = '/add_management';
  static String addVirtualipRoute = '/add_virtualip';
  static String manageVirtualipRoute = '/manage_virtualip';
  static String nginxLogRoute = '/nginx_log';
  static String userActionLogRoute = '/user_actionlog';
  static String internalErrorLogRoute = '/internal_errorlog';
  static String mediaRoute = '/media';
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
    GetPage(name: manageNginxRoute, page: () => const ManageNginxScreen()),
    GetPage(
      name: activeConnectionRoute,
      page: () => const ActiveConnectionsScreen(),
    ),
    GetPage(
      name: generalConfigurationRoute,
      page: () => const GeneralConfigurationScreen(),
    ),
    GetPage(name: userManagmentRoute, page: () => const UserManagementScreen()),
    GetPage(name: mediaRoute, page: () => const MediaScreen()),
    GetPage(name: addUserManagmentRoute, page: () => const AddUserScreen()),
    GetPage(name: addVirtualipRoute, page: () => const AddVirtualIPScreen()),
    GetPage(
        name: manageVirtualipRoute, page: () => const ManageVirtualIPSCreen()),
    GetPage(name: systemRoute, page: () => const RoutesScreen()),
    GetPage(name: nginxLogRoute, page: () => const NginxLogScreen()),
    GetPage(name: userActionLogRoute, page: () => const UserActionLogScreen()),
    GetPage(
        name: internalErrorLogRoute,
        page: () => const InternalErrorLogScreen()),
    GetPage(name: settingRoute, page: () => Settingscreen()),
    GetPage(name: otpRoute, page: () => OtpScreen()),
    GetPage(name: docRoute, page: () => DocScreen()),
  ];
}

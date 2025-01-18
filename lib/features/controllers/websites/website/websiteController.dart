import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/models/website.dart';
import 'package:msf/core/services/unit/api/HttpService.dart';

class WebsiteController extends GetxController {
  final RxList<Website> websites = <Website>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWebsites();
  }

  void addWebsite(String name, String url, String zipPath) {
    websites.add(
        Website(
      name: name,
      url: url,
      author: "admin",
      status: 'Waiting for zip',
      initStatus: false,
      zipPath: zipPath,
    ));
  }

  void updateStatus(Website website, String newStatus) {
    website.status.value = newStatus;
  }

  void removeWebsite(Website website) {
    websites.remove(website);
  }

  Future<void> deployWebsite(Website website) async {
    try {
      String fileNameWithExtension = '${website.name}.zip';

      final response = await HttpService().deployFile(fileNameWithExtension);
      if (response.statusCode == 200) {
        website.status.value = 'Deployed';
        Get.snackbar(
          "Deployment Successful",
          "Your website has been deployed successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error",
          "Deployment failed. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred during the deployment: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> fetchWebsites() async {
    try {
      // دریافت داده‌ها از HttpService
      List<Website> websiteList = await HttpService().fetchAppList();

      // به روز رسانی لیست websites
      websites.assignAll(websiteList);
    } catch (e) {
      // نمایش پیام خطا
      Get.snackbar(
        "Error",
        "Failed to fetch websites: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }


}

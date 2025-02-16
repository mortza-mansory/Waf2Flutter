import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:msf/core/services/unit/api/HttpService.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/waf/WafController.dart';
import 'package:msf/features/dashboard/component/CircleChar.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the controller (make sure it is already instantiated via Get.put)
    final wafController = Get.find<WafLogController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: secondryColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "Status".tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 30),
          // Use Obx to update status based on modStatus:
          Obx(() {
            bool isOn = wafController.modStatus.value;
            return CircleChart(
              circleColor:
              isOn ? Colors.greenAccent : Colors.redAccent,
              mainText: isOn ? "Safe" : "Unsafe",
              subText: isOn ? "WAF is ON!" : "WAF is OFF!",
            );
          }),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: primaryColor.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.visibility_outlined,
                    color: Colors.blueAccent),
                const SizedBox(width: 10),
                AutoSizeText(
                  "Visitors: ".tr,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const AutoSizeText(
                  "143000",
                  maxLines: 1,
                  style:
                  TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Last refresh using the controller's lastRefresh:
          Obx(() => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.greenAccent.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.wifi_protected_setup_rounded,
                    color: Colors.greenAccent),
                const SizedBox(width: 10),
                AutoSizeText(
                  "Last refresh: ".tr,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 12),
                ),
                AutoSizeText(
                  wafController.lastRefresh.value,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w100, fontSize: 12),
                ),
              ],
            ),
          )),
          const SizedBox(height: 30),
          // Warnings (renamed from "Suspected")
          Obx(() => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.yellowAccent.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.supervised_user_circle_outlined,
                    color: Colors.yellowAccent),
                const SizedBox(width: 10),
                AutoSizeText(
                  "Warnings: ".tr,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AutoSizeText(
                  wafController.warningsCount.value.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w100, fontSize: 12),
                ),
              ],
            ),
          )),
          const SizedBox(height: 30),
          // Critical warnings
          Obx(() => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.redAccent.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield_outlined, color: Colors.redAccent),
                const SizedBox(width: 10),
                AutoSizeText(
                  "Critical: ".tr,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                AutoSizeText(
                  wafController.criticalCount.value.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w100, fontSize: 12),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

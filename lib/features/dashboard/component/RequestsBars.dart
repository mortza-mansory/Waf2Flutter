import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/waf/WafController.dart';

class RequestsBars extends StatelessWidget {
  const RequestsBars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WafLogController controller = Get.find<WafLogController>();

    return Container(
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() {
        int total = controller.allCount.value;
        double warningsProgress =
        total > 0 ? controller.warningsCount.value / total : 0;
        double criticalProgress =
        total > 0 ? controller.criticalCount.value / total : 0;
        double messagesProgress =
        total > 0 ? controller.messagesCount.value / total : 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Log Statistics",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            _buildStatBar(
              label: "All Requests",
              value: total.toString(),
              progress: 1.0,
              barColor: Colors.grey,
              context: context,
            ),
            const SizedBox(height: 16),
            _buildStatBar(
              label: "Warnings",
              value: controller.warningsCount.value.toString(),
              progress: warningsProgress,
              barColor: Colors.yellowAccent,
              context: context,
            ),
            const SizedBox(height: 16),
            _buildStatBar(
              label: "Critical",
              value: controller.criticalCount.value.toString(),
              progress: criticalProgress,
              barColor: Colors.redAccent,
              context: context,
            ),
            const SizedBox(height: 16),
            // Messages bar
            _buildStatBar(
              label: "Messages",
              value: controller.messagesCount.value.toString(),
              progress: messagesProgress,
              barColor: Colors.blueAccent,
              context: context,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatBar({
    required String label,
    required String value,
    required double progress,
    required Color barColor,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(value, style: const TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 4),
        LayoutBuilder(
          builder: (context, constraints) {
            double fullWidth = constraints.maxWidth;
            double filledWidth = fullWidth * progress;
            return Stack(
              children: [
                Container(
                  width: fullWidth,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: filledWidth,
                  height: 20,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

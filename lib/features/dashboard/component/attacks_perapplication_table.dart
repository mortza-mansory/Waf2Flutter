import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/features/controllers/dashboard/RecentActivityController.dart';

class AttacksPerApplicationTable extends StatelessWidget {
  const AttacksPerApplicationTable({
    super.key,
    required Color secondryColor,
  });

  @override
  Widget build(BuildContext context) {
    final recentActivityController = Get.put(RecentActivityController());
    // Scroll controller for the horizontal scrolling
    final scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attacks per Application".tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Expanded(
              child: Obx(() {
                return Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 100,
                      horizontalMargin: 5,
                      border: TableBorder.all(
                        color: Colors.white,
                        width: 0.1,
                      ),
                      columns: [
                        const DataColumn(label: Text("#")),
                        DataColumn(label: Text("Application".tr)),
                        DataColumn(label: Text("Critical".tr)),
                        DataColumn(label: Text("Warning".tr)),
                        DataColumn(label: Text("Notice".tr)),
                        DataColumn(label: Text("Errors".tr)),
                        DataColumn(label: Text("Requests".tr)),
                      ],
                      rows: recentActivityController.recentActivities.map((activity) {
                        return DataRow(cells: [
                          DataCell(Text(activity.id.toString())),
                          DataCell(Text(Uri.parse(activity.app).host)),
                          DataCell(Text(activity.cr.toString())),
                          DataCell(Text(activity.w.toString())),
                          DataCell(Text(activity.n.toString())),
                          DataCell(Text(activity.e.toString())),
                          DataCell(Text(activity.r.toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

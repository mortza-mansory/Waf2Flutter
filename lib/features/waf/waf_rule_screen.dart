import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/services/unit/api/config/Config.dart';
import 'package:msf/core/utills/responsive.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/features/controllers/waf/WafRule.dart';
import 'package:msf/features/waf/components/add_new_rule.dart';

class WafRuleScreen extends StatelessWidget {
  WafRuleScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final WafRuleController wafController = Get.find<WafRuleController>();

  final TextEditingController searchController = TextEditingController();

  Widget _buildIpContainer(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget _buildSearchContainer(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Search among rules:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            width: Responsive.isDesktop(context)
                ? screenWidth * 0.4
                : screenWidth * 0.8,
            height: 60,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Type rule name...",
                fillColor: const Color(0xFF404456),
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {
                wafController.searchQuery.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
  String extractIp(String address) {
    String ip = address;
    if (ip.startsWith("http://")) {
      ip = ip.substring(7);
    } else if (ip.startsWith("https://")) {
      ip = ip.substring(8);
    }
    if (ip.contains(":")) {
      ip = ip.split(":")[0];
    }
    return ip;
  }

  Widget _buildIpRow(BuildContext context) {
    final ip = extractIp(Config.httpAddress.toString());

    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          _buildIpContainer(context, "Your IP Server: $ip"),
          const SizedBox(height: 10),
          _buildSearchContainer(context),
        ],
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: _buildIpContainer(context, "Your IP Server: $ip"),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: _buildSearchContainer(context),
            ),
          ],
        ),
      );
    }
  }


  Widget _buildCreateNewRule(BuildContext context) {
    Widget container = GestureDetector(
      onTap: () {
        Get.to(() => AddNewRule());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.add),
            const SizedBox(width: 60),
            Text("Create New Rule",
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
    if (Responsive.isMobile(context)) {
      return SizedBox(height: 80, child: container);
    }
    return container;
  }

  Widget _buildBackupRestoreContainer(BuildContext context) {
    // Define a button style with white text and icon colors
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white, // Sets both text and icon color to white
      textStyle: const TextStyle(color: Colors.white),
    );

    // Always arrange buttons in a row
    Widget containerContent = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            wafController.downloadBackup();
          },
          style: buttonStyle,
          icon: const Icon(Icons.download, color: Colors.white),
          label: const Text("Download", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            bool success = await wafController.restoreBackup();
            if (success) {
              Get.snackbar("Success", "Rules restored successfully");
            } else {
              Get.snackbar("Error", "Failed to restore rules");
            }
          },
          style: buttonStyle,
          icon: const Icon(Icons.restore, color: Colors.white),
          label: const Text("Restore", style: TextStyle(color: Colors.white)),
        ),
      ],
    );

    Widget container = Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: containerContent,
    );

    return SizedBox(height: 60, child: container);
  }


  Widget _buildTopActionRow(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          _buildCreateNewRule(context),
          const SizedBox(height: 16),
          _buildBackupRestoreContainer(context),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(flex: 65, child: _buildCreateNewRule(context)),
          const SizedBox(width: 16),
          Expanded(flex: 35, child: _buildBackupRestoreContainer(context)),
        ],
      );
    }
  }

  void _showEditRuleDialog(BuildContext context, String ruleName) async {
    await wafController.fetchRuleContent(ruleName);
    TextEditingController textController = TextEditingController(
      text: wafController.selectedRuleContent.value,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Rule: $ruleName"),
          content: Obx(() => wafController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : TextField(
            controller: textController,
            maxLines: 6,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter rule content...",
            ),
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                bool updated = await wafController.updateRuleContent(
                  ruleName,
                  textController.text,
                );
                Navigator.pop(context);
                if (updated) {
                  Get.snackbar("Success", "Rule updated successfully");
                } else {
                  Get.snackbar("Error", "Failed to update rule");
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        _buildIpRow(context),
        const SizedBox(height: 16),
        _buildTopActionRow(context),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Manage ModSecurity rules and configuration",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                if (wafController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                var filteredRules = wafController.rules
                    .where((rule) => rule["name"]
                    .toString()
                    .toLowerCase()
                    .contains(
                    wafController.searchQuery.value.toLowerCase()))
                    .toList();

                return DataTable(
                  columnSpacing: 16.0,
                  columns: const [
                    DataColumn(
                      label: Text(
                        "Rule Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Edit Rule"),
                    ),
                    DataColumn(
                      label: Text("Remove"),
                    ),
                  ],
                  rows: filteredRules.map((rule) {
                    return DataRow(
                      cells: [
                        DataCell(Text(rule["name"] ?? "")),
                        DataCell(
                          Tooltip(
                            message:
                            "This shows the status of the rule (enabled/disabled)",
                            child: Switch(
                              activeColor: Colors.green,
                              activeTrackColor: Colors.green.withOpacity(0.5),
                              inactiveThumbColor: Colors.red,
                              inactiveTrackColor: Colors.red.withOpacity(0.5),
                              value: (rule["status"] ?? "") == "enabled",
                              onChanged: (bool value) async {
                                bool success = await wafController.toggleRule(
                                  rule["name"],
                                  rule["status"],
                                );
                                if (success) {
                                  Get.snackbar("Success", "Rule status updated.");
                                } else {
                                  Get.snackbar("Error", "Failed to update rule status.");
                                }
                              },
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 100,
                            child: CustomIconbuttonWidget(
                              title: "Edit Rule",
                              icon: Icons.edit_square,
                              backColor: Colors.green[200]!,
                              titleColor: Colors.green[900]!,
                              iconColor: Colors.green[900]!,
                              onPressed: () => _showEditRuleDialog(context, rule["name"]),
                            ),
                          ),
                        ),
                        DataCell(
                          Tooltip(
                            message: "You can delete this rule via this key",
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                bool success = await wafController.deleteRule(rule["name"]);
                                if (success) {
                                  Get.snackbar("Success", "Rule deleted successfully");
                                } else {
                                  Get.snackbar("Error", "Failed to delete rule");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

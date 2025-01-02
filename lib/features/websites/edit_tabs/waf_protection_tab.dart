import 'package:flutter/material.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';

class WafProtectionTab extends StatelessWidget {
  WafProtectionTab({super.key});

  final List<Map<String, dynamic>> ruleData = [
    {
      "ruleName": "REQUEST-901-INITIALIZATION",
      "isEnabled": true,
      "editAction": () {
        print("Edit REQUEST-901-INITIALIZATION");
      }
    },
    {
      "ruleName": "REQUEST-902-CUSTOM-RULE",
      "isEnabled": false,
      "editAction": () {
        print("Edit REQUEST-902-CUSTOM-RULE");
      }
    },
    {
      "ruleName": "REQUEST-903-OTHER-RULE",
      "isEnabled": true,
      "editAction": () {
        print("Edit REQUEST-903-OTHER-RULE");
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Manage modesecurity rules and configuration"),
        const SizedBox(height: 10),
        DataTable(
          columns: const [
            DataColumn(
              label: Text("CRS Configuration"),
            ),
            DataColumn(
              label: Text("Edit"),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                const DataCell(
                  Text("crs-setup.conf"),
                ),
                DataCell(
                  SizedBox(
                    width: 150,
                    child: CustomIconbuttonWidget(
                      title: "Edit configuration",
                      icon: Icons.edit_square,
                      backColor: Colors.yellow[100]!,
                      titleColor: Colors.yellow[900]!,
                      iconColor: Colors.yellow[900]!,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        const Divider(color: Colors.blue, thickness: 3),
        const SizedBox(height: 30),
        DataTable(
          columnSpacing: 16.0,
          columns: const [
            DataColumn(
              label: Text(
                "Rule Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text("ON-Off"),
            ),
            DataColumn(
              label: Text("Edit Rule"),
            ),
          ],
          rows: ruleData
              .map(
                (data) => DataRow(
                  cells: [
                    DataCell(
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 150),
                        child: Text(
                          data['ruleName'],
                          style: const TextStyle(fontSize: 14),
                          softWrap: true,
                        ),
                      ),
                    ),
                    DataCell(
                      Switch(
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.white,
                        inactiveTrackColor: Colors.red,
                        value: data['isEnabled'],
                        onChanged: (bool value) {
                          print(
                              "${data['ruleName']} is now ${value ? 'enabled' : 'disabled'}");
                        },
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 100,
                        child: CustomIconbuttonWidget(
                          title: "Edit Rules",
                          icon: Icons.edit_square,
                          backColor: Colors.green[200]!,
                          titleColor: Colors.green[900]!,
                          iconColor: Colors.green[900]!,
                          onPressed: data['editAction'],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

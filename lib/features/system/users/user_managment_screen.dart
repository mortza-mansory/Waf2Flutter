import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_dropdown.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/component/widgets/status_widget.dart';
import 'package:msf/core/router/app_router.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';

import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';
import 'package:msf/core/utills/responsive.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final ScrollController scrollbarController = ScrollController();
  TextEditingController gatewayTextcontroller = TextEditingController();
  @override
  void dispose() {
    gatewayTextcontroller.dispose();
    super.dispose();
  }

  final List<String> ipList = [
    "192.168.1.1 - Available",
  ];
  final List<String> interfaces = [
    "ens-33",
  ];
  int? _sortColumnIndex;
  bool _isAscending = true;
  final List<Map<String, dynamic>> _data = List.generate(
    5,
    (index) => {
      "id": index + 1,
      "Firstname": "User $index",
      "Lastname": "Lastname $index",
      "Email": "user$index@example.com",
      "Username": "user_$index",
    },
  );
  void _sortData(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      if (columnIndex == 0) {
        _data.sort((a, b) => ascending
            ? a["id"].compareTo(b["id"])
            : b["id"].compareTo(a["id"]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Row(
          children: [
            const Text("User Management"),
            const SizedBox(width: 16),
            CustomIconbuttonWidget(
              backColor: primaryColor,
              onPressed: () => Get.toNamed(AppRouter.addUserManagmentRoute),
              title: "Add User",
            )
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scrollbar(
            controller: scrollbarController,
            child: SingleChildScrollView(
              controller: scrollbarController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20.0,
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _isAscending,
                columns: [
                  DataColumn(
                    label: SizedBox(
                      width: 25,
                      child: Text(
                        "ID",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onSort: (columnIndex, ascending) {
                      _sortData(columnIndex, ascending);
                    },
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 100,
                      child: Text(
                        "First Name",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 150,
                      child: Text(
                        "Last Name",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 250,
                      child: Text(
                        "E-Mail",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 150,
                      child: Text(
                        "Username",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const DataColumn(label: SizedBox()), // Actions
                ],
                rows: _data.map((row) {
                  return DataRow(
                    cells: [
                      DataCell(Text(row["id"].toString())),
                      DataCell(Text(row["Firstname"],
                          overflow: TextOverflow.ellipsis)),
                      DataCell(Text(row["Lastname"],
                          overflow: TextOverflow.ellipsis)),
                      DataCell(
                          Text(row["Email"], overflow: TextOverflow.ellipsis)),
                      DataCell(Text(row["Username"],
                          overflow: TextOverflow.ellipsis)),
                      DataCell(
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              CustomIconbuttonWidget(
                                backColor: Colors.white10,
                                onPressed: () {},
                                icon: Icons.zoom_in,
                                title: "View",
                              ),
                              const SizedBox(width: 5),
                              CustomIconbuttonWidget(
                                backColor: Colors.white10,
                                onPressed: () {},
                                icon: Icons.edit,
                                title: "Edit",
                              ),
                              const SizedBox(width: 5),
                              CustomIconbuttonWidget(
                                backColor: Colors.white10,
                                onPressed: () {},
                                icon: Icons.delete,
                                title: "Delete",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

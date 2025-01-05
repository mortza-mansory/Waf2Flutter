import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_dropdown.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/component/widgets/status_widget.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';

import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';
import 'package:msf/core/utills/responsive.dart';

class ActiveConnectionsScreen extends StatefulWidget {
  const ActiveConnectionsScreen({super.key});

  @override
  State<ActiveConnectionsScreen> createState() =>
      _ActiveConnectionsScreenState();
}

class _ActiveConnectionsScreenState extends State<ActiveConnectionsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final ScrollController scrollbarController = ScrollController();
  TextEditingController gatewayTextcontroller = TextEditingController();
  @override
  void dispose() {
    gatewayTextcontroller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _data = [
    {
      "#": 1,
      "Source": "Debian::ssh",
      "Destination": "Mopc",
    },
    {
      "#": 2,
      "Source": "Debian::ssh",
      "Destination": "Mopc",
    },
    {
      "#": 3,
      "Source": "Debian::ssh",
      "Destination": "Mopc",
    },
  ];
  int? _sortColumnIndex;
  bool _isAscending = true;

  void _sortData(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      switch (columnIndex) {
        case 0: // Sort by #
          _data.sort((a, b) =>
              ascending ? a["#"].compareTo(b["#"]) : b["#"].compareTo(a["#"]));
          break;
        case 1: // Sort by Log
          _data.sort((a, b) => ascending
              ? a["Log"].compareTo(b["Log"])
              : b["Log"].compareTo(a["Log"]));
          break;
        case 4: // Sort by Date
          _data.sort((a, b) => ascending
              ? a["Date"].compareTo(b["Date"])
              : b["Date"].compareTo(a["Date"]));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Row(
          children: [
            const Text("Active Connections "),
            StatusWidget(
              title: _data.length.toString(),
              backgrounColor: primaryColor,
              titleColor: Colors.white,
            )
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _isAscending,
                columns: [
                  DataColumn(
                    label: const Text("#"),
                    numeric: false, // Set to false for left alignment
                    headingRowAlignment:
                        MainAxisAlignment.start, // Align heading left
                    onSort: (columnIndex, ascending) {
                      _sortData(columnIndex, ascending);
                    },
                  ),
                  DataColumn(
                    label: const Text("Source"),
                    numeric: false, // Set to false for left alignment
                    headingRowAlignment:
                        MainAxisAlignment.start, // Align heading left
                  ),
                  DataColumn(
                    label: const Text("Destination"),
                    numeric: false, // Set to false for left alignment
                    headingRowAlignment:
                        MainAxisAlignment.start, // Align heading left
                  ),
                ],
                rows: _data.map((row) {
                  return DataRow(cells: [
                    DataCell(
                        Text(row["#"].toString(), textAlign: TextAlign.left)),
                    DataCell(Text(row["Source"], textAlign: TextAlign.left)),
                    DataCell(
                        Text(row["Destination"], textAlign: TextAlign.left)),
                  ]);
                }).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

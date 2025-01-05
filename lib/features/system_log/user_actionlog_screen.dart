import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_dropdown.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/core/utills/responsive.dart';

class UserActionLogScreen extends StatefulWidget {
  const UserActionLogScreen({super.key});

  @override
  State<UserActionLogScreen> createState() => _UserActionLogScreenState();
}

class _UserActionLogScreenState extends State<UserActionLogScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollbarController = ScrollController();

  // Sample Data
  final List<Map<String, dynamic>> _data = List.generate(
    20,
    (index) => {
      "dateTime": DateTime.now().subtract(Duration(minutes: index * 15)),
      "username": "user_${index + 1}",
      "description": "Performed action ${index + 1}.",
    },
  );

  // Sorting Configuration
  int? _sortColumnIndex;
  bool _isAscending = true;

  // Dropdown & Search Logic
  int selectedEntries = 10;
  List<int> entryOptions = [10, 25, 50, 100];
  TextEditingController searchTextController = TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void _sortData(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      switch (columnIndex) {
        case 0: // Sort by DateTime
          _data.sort((a, b) => ascending
              ? a["dateTime"].compareTo(b["dateTime"])
              : b["dateTime"].compareTo(a["dateTime"]));
          break;
        case 1: // Sort by Username
          _data.sort((a, b) => ascending
              ? a["username"].compareTo(b["username"])
              : b["username"].compareTo(a["username"]));
          break;
        case 2: // Sort by Description
          _data.sort((a, b) => ascending
              ? a["description"].compareTo(b["description"])
              : b["description"].compareTo(a["description"]));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Text("Show"),
                        const SizedBox(width: 5),
                        Flexible(
                            child: CustomDropdownWidget(
                          list: entryOptions,
                          value: selectedEntries,
                          onchangeValue: (newVal) {
                            setState(() {
                              selectedEntries = newVal;
                            });
                          },
                        )),
                        const SizedBox(width: 5),
                        const Text("entries"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Search"),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 150,
                        child: DashboardTextfield(
                          textEditingController: searchTextController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // DataTable with Logs
              Scrollbar(
                controller: scrollbarController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: scrollbarController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _isAscending,
                    columns: [
                      DataColumn(
                        label: SizedBox(
                            width: 150, child: const Text("Date & Time")),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label:
                            SizedBox(width: 50, child: const Text("Username")),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: Expanded(
                            child: const Text(
                          "Description",
                        )),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                    ],
                    rows: _data.map((row) {
                      return DataRow(cells: [
                        DataCell(Text(
                          row["dateTime"].toString().split('.')[0],
                        )),
                        DataCell(Text(row["username"])),
                        DataCell(Text(
                          row["description"],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Footer
              Text(
                "Showing ${_data.isNotEmpty ? 1 : 0} to ${_data.length} of ${_data.length} entries",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

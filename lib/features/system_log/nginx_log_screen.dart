import 'package:flutter/material.dart';

import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_dropdown.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/colorconfig.dart';

class NginxLogScreen extends StatefulWidget {
  const NginxLogScreen({super.key});

  @override
  State<NginxLogScreen> createState() => _NginxLogScreenState();
}

class _NginxLogScreenState extends State<NginxLogScreen> {
  TextEditingController searchTextController = TextEditingController();
  final ScrollController scrollbarController = ScrollController();

  // Sample Data
  final List<Map<String, dynamic>> _data = List.generate(
    20,
    (index) => {
      "#": index + 1,
      "log":
          "Sample log entry number ${index + 1}. This is just a placeholder for log data.",
    },
  );

  // Sorting Configuration
  int? _sortColumnIndex;
  bool _isAscending = true;

  // Dropdown & Search Logic
  int selectedEntries = 10;
  List<int> entryOptions = [10, 25, 50, 100];

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void _sortData(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;

      if (columnIndex == 0) {
        _data.sort((a, b) =>
            ascending ? a["#"].compareTo(b["#"]) : b["#"].compareTo(a["#"]));
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enginx Logs"),
                      const SizedBox(height: 15),
                      Text("showing last ${_data.length} from nginx logs"),
                    ],
                  ),
                  CustomIconbuttonWidget(
                    backColor: primaryColor,
                    onPressed: () {},
                    title: "Download Full Log",
                    icon: Icons.download,
                  )
                ],
              ),
              const SizedBox(height: 35),
              const Divider(color: primaryColor, thickness: 0.5),
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
                        label: const SizedBox(
                          width: 15,
                          child: Text("#"),
                        ),
                        numeric: true,
                        headingRowAlignment: MainAxisAlignment.center,
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      const DataColumn(
                        label: Text("Logs"),
                      ),
                    ],
                    rows: _data.map((row) {
                      return DataRow(cells: [
                        DataCell(Center(
                          child: Text(
                            row["#"].toString(),
                          ),
                        )),
                        DataCell(
                          Text(
                            row["log"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

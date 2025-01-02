import 'package:flutter/material.dart';

import 'package:msf/core/component/widgets/dashboard_textfield.dart';

class DownloadLog extends StatefulWidget {
  const DownloadLog({super.key});

  @override
  State<DownloadLog> createState() => _DownloadLogState();
}

class _DownloadLogState extends State<DownloadLog> {
  TextEditingController searchTextController = TextEditingController();
  final List<int> entryOptions = [10, 20, 50, 100];
  int selectedEntries = 10;
  final int _currentPage = 1;
  // Sample table data
  final List<Map<String, dynamic>> _data = [
    {
      "#": 1,
      "Log": "Error Log 1",
      "Type": "Error",
      "Size": "15KB",
      "Date": "2024-01-01",
      "Download": "Available"
    },
    {
      "#": 2,
      "Log": "Warning Log 2",
      "Type": "Warning",
      "Size": "10KB",
      "Date": "2024-01-03",
      "Download": "Available"
    },
    {
      "#": 3,
      "Log": "Info Log 3",
      "Type": "Info",
      "Size": "25KB",
      "Date": "2024-01-02",
      "Download": "Unavailable"
    },
  ];

  int? _sortColumnIndex; // Tracks the sorted column index
  bool _isAscending = true; // Tracks sort order

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

  int get _startIndex => (_currentPage - 1) * selectedEntries;
  int get _endIndex => (_startIndex + selectedEntries > _data.length)
      ? _data.length
      : _startIndex + selectedEntries;
  @override
  Widget build(BuildContext context) {
    final displayedData = _data.sublist(_startIndex, _endIndex);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Download rotated logs"),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Existing Row for dropdown and search
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text("Show"),
                      const SizedBox(width: 5),
                      Flexible(
                        child: DropdownButton<int>(
                          value: selectedEntries,
                          dropdownColor: Colors.grey[800],
                          items: entryOptions.map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              if (newVal != null) selectedEntries = newVal;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Flexible(child: Text("entries")),
                    ],
                  ),
                ),
                const Spacer(),
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

            // Sortable DataTable
            DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _isAscending,
              columns: [
                DataColumn(
                  label: const Text("#"),
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    _sortData(columnIndex, ascending);
                  },
                ),
                DataColumn(
                  label: const Text("Log"),
                  onSort: (columnIndex, ascending) {
                    _sortData(columnIndex, ascending);
                  },
                ),
                const DataColumn(label: Text("Type")),
                const DataColumn(label: Text("Size")),
                DataColumn(
                  label: const Text("Date"),
                  onSort: (columnIndex, ascending) {
                    _sortData(columnIndex, ascending);
                  },
                ),
                const DataColumn(label: Text("Download")),
              ],
              rows: _data.map((row) {
                return DataRow(cells: [
                  DataCell(Text(row["#"].toString())),
                  DataCell(Text(row["Log"])),
                  DataCell(Text(row["Type"])),
                  DataCell(Text(row["Size"])),
                  DataCell(Text(row["Date"])),
                  DataCell(Text(row["Download"])),
                ]);
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Footer
        Text(
          "Showing ${displayedData.isNotEmpty ? _startIndex + 1 : 0} to $_endIndex of ${_data.length} entries",
        ),
      ],
    );
  }
}

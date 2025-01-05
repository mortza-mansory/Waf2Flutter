import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/status_widget.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/core/utills/responsive.dart';

class ManageVirtualIPSCreen extends StatefulWidget {
  const ManageVirtualIPSCreen({super.key});

  @override
  State<ManageVirtualIPSCreen> createState() => _ManageVirtualIPSCreenState();
}

class _ManageVirtualIPSCreenState extends State<ManageVirtualIPSCreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollbarController = ScrollController();

  final List<Map<String, dynamic>> _data = [
    {
      "#": 1,
      "ip": "192.168.1.1",
      "interface": "ens33:11",
      "usedby": "null",
      "status": "Available",
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Responsive(
              mobile: Scrollbar(
                controller: scrollbarController,
                child: SingleChildScrollView(
                  controller: scrollbarController,
                  scrollDirection: Axis.horizontal,
                  child: ipTable(),
                ),
              ),
              tablet: Scrollbar(
                controller: scrollbarController,
                child: SingleChildScrollView(
                  controller: scrollbarController,
                  scrollDirection: Axis.horizontal,
                  child: ipTable(),
                ),
              ),
              desktop: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [ipTable()],
              ),
            )),
      ],
    );
  }

  Widget ipTable() => DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _isAscending,
        columns: [
          DataColumn(
            label: const Text("#"),
            onSort: (columnIndex, ascending) {
              _sortData(columnIndex, ascending);
            },
          ),
          const DataColumn(
            label: Text("IP"),
          ),
          const DataColumn(
            label: Text("Interface"),
          ),
          const DataColumn(
            label: Text("Used By"),
          ),
          const DataColumn(
            label: Text("Status"),
          ),
          const DataColumn(
            label: Text("Delete"),
          ),
        ],
        rows: _data.map((row) {
          return DataRow(cells: [
            dataCellMaker(row["#"].toString()),
            dataCellMaker(row["ip"]),
            dataCellMaker(row["interface"]),
            dataCellMaker(row["usedby"]),
            DataCell(StatusWidget(
              title: row["status"],
              backgrounColor: primaryColor,
              titleColor: Colors.white,
            )),
            DataCell(
              SizedBox(
                width: 70,
                child: CustomIconbuttonWidget(
                  backColor: Colors.red,
                  onPressed: () {},
                  icon: Icons.delete,
                ),
              ),
            ),
          ]);
        }).toList(),
      );

  DataCell dataCellMaker(dynamic title) => DataCell(SizedBox(
        width: 110,
        child: Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 2, // Add wrapping to limit overflow
        ),
      ));
}

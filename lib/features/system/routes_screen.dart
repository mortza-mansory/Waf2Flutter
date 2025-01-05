import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_dropdown.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';

import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';
import 'package:msf/core/utills/responsive.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
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
  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              configGateway,
              const SizedBox(width: 10, height: 10),
              routesSection
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: configGateway),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: routesSection),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: configGateway),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: routesSection),
            ],
          ),
        ),
      ],
    );
  }

  Widget get configGateway {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AutoSizeText(
            "Nginx Actions",
            maxLines: 1,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const AutoSizeText(
                "IP Virtual:",
                maxLines: 1,
              ),
              SizedBox(width: 10),
              CustomDropdownWidget(
                list: ipList,
                value: ipList[0],
                onchangeValue: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 15),
          const AutoSizeText(
            "Gateway",
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          DashboardTextfield(
            textEditingController: gatewayTextcontroller,
            maxLength: 16,
            hintText: "192.168.1.1",
            inputType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const AutoSizeText(
                "Interface:",
                maxLines: 1,
              ),
              SizedBox(width: 10),
              CustomDropdownWidget(
                list: interfaces,
                value: interfaces[0],
                onchangeValue: (value) {},
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 30,
            width: 100,
            child: CustomIconbuttonWidget(
              backColor: primaryColor,
              onPressed: () {},
              title: "Add",
            ),
          )
        ],
      ),
    );
  }

  Widget get routesSection => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AutoSizeText(
                  "Routes",
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                DataTable(
                  columnSpacing: 30,
                  border: TableBorder.all(
                    color: Colors.white,
                    width: 0.07,
                  ),
                  columns: [
                    DataColumnTile.buildRow(title: 'Destination'),
                    DataColumnTile.buildRow(title: 'Gateway'),
                    DataColumnTile.buildRow(title: 'Genmask'),
                    DataColumnTile.buildRow(title: 'iface'),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('0.0.0.0')),
                        DataCell(Text('192.168.70.1')),
                        DataCell(Text('0.0.0.0')),
                        DataCell(Text("ens33")),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

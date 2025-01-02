import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/status_widget.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/core/utills/responsive.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/log_chart.dart';
import 'package:msf/features/websites/log_tabs/download_log.dart';
import 'package:msf/features/websites/log_tabs/log_maker.dart';
import 'package:msf/features/websites/log_tabs/manual_exclusion.dart';

class WebsitesLogScreen extends StatefulWidget {
  const WebsitesLogScreen({
    super.key,
  });

  @override
  State<WebsitesLogScreen> createState() => _WebsitesLogScreenState();
}

class _WebsitesLogScreenState extends State<WebsitesLogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController scrollbarController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final String title = Get.arguments ?? "";
  int _selectedTabIndex = 0;
  final List<Map<String, dynamic>> sampleData = [
    {
      "#": 1,
      "Log": "this is a simple log which you need",
    },
    {
      "#": 2,
      "Log": "this is a simple log which you need",
    },
    {
      "#": 3,
      "Log": "this is a simple log which you need",
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 9, vsync: this);
    super.initState();

    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<IdleController>().onUserInteraction();
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: !Responsive.isDesktop(context)
            ? const Drawer(
                child: SideBar(),
              )
            : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideBar(),
              ),
            Expanded(
              flex: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Header(scaffoldKey: scaffoldKey),
                      const SizedBox(height: 16),
                      title != ""
                          ? Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(title),
                            )
                          : const SizedBox.shrink(),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Scrollbar(
                              controller: scrollbarController,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: scrollbarController,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: TabBar(
                                    controller: _tabController,
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    indicator: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          width: 2,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    labelColor: Colors.white,
                                    tabs: [
                                      Tab(text: "Summory".tr),
                                      Tab(text: "Attacks".tr),
                                      Tab(text: "Manual Exclusion".tr),
                                      Tab(text: "Rules Excluded".tr),
                                      Tab(text: "Download Logs".tr),
                                      Tab(text: "Access Logs".tr),
                                      Tab(text: "Error Logs".tr),
                                      Tab(text: "Attack Logs".tr),
                                      Tab(text: "Debug Logs".tr),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // active websites
                            const SizedBox(height: 16),
                            if (_selectedTabIndex == 0) ...[
                              summaryTab()
                            ] else if (_selectedTabIndex == 1) ...[
                              attack()
                            ] else if (_selectedTabIndex == 2) ...[
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ManualExclusion(),
                              )
                            ] else if (_selectedTabIndex == 3) ...[
                              const SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Rules Excluded"),
                                    SizedBox(height: 10),
                                    Text("There are no Excluded rules"),
                                  ],
                                ),
                              ),
                            ] else if (_selectedTabIndex == 4) ...[
                              const DownloadLog()
                            ] else if (_selectedTabIndex == 5) ...[
                              LogMaker(title: "Access Logs", logs: sampleData)
                            ] else if (_selectedTabIndex == 6) ...[
                              LogMaker(title: "Error Logs", logs: sampleData)
                            ] else if (_selectedTabIndex == 7) ...[
                              LogMaker(title: "Attack Logs", logs: sampleData)
                            ] else if (_selectedTabIndex == 8) ...[
                              LogMaker(title: "Debug Logs", logs: sampleData)
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryTab() {
    SizedBox betweenSpace() => const SizedBox(width: 5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Attack Summary"),
        const SizedBox(
          height: 350,
          width: double.infinity,
          child:
              LogChart(), // No need for 'Expanded' here, just put the widget inside a SizedBox
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use Flexible correctly inside Row or Column
            Flexible(
              child: StatusWidget(
                title: "Critical: 0",
                backgrounColor: Colors.red[900],
                titleColor: Colors.white,
              ),
            ),
            betweenSpace(),
            Flexible(
              child: StatusWidget(
                title: "Warning: 0",
                backgrounColor: Colors.yellow[700],
                titleColor: Colors.grey[800],
              ),
            ),
            betweenSpace(),
            Flexible(
              child: StatusWidget(
                title: "Notice: 0",
                backgrounColor: Colors.green[700],
                titleColor: Colors.white,
              ),
            ),
            betweenSpace(),
            Flexible(
              child: StatusWidget(
                title: "Error: 0",
                backgrounColor: Colors.red[100],
                titleColor: Colors.red[800],
              ),
            ),
            betweenSpace(),
            const Flexible(
              child: StatusWidget(
                title: "Total request: 0",
                backgrounColor: Colors.white38,
                titleColor: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget attack() {
    final ScrollController attackScrollbarController = ScrollController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Showing last 1000 audits logs"),
            CustomIconbuttonWidget(
              backColor: primaryColor,
              title: "Reload",
              onPressed: () {},
            ),
          ],
        ),
        // disable websites datatable
        Scrollbar(
          controller: attackScrollbarController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: attackScrollbarController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: DataTable(
                columnSpacing: 30,
                border: TableBorder.all(
                  color: Colors.white,
                  width: 0.07,
                ),
                columns: [
                  DataColumnTile.buildRow(title: 'Name'),
                  DataColumnTile.buildRow(title: 'Application'),
                  DataColumnTile.buildRow(title: 'Status'),
                  DataColumnTile.buildRow(title: 'Actions'),
                ],
                rows: const [],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

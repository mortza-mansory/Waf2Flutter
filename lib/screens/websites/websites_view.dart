import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/controllers/settings/IdleController.dart';
import 'package:msf/controllers/settings/MenuController.dart';

import 'package:msf/screens/component/Header.dart';
import 'package:msf/screens/component/SideBar.dart';
import 'package:msf/screens/websites/components/data_column_tile.dart';
import 'package:msf/screens/websites/components/data_row_tile.dart';
import 'package:msf/utills/colorconfig.dart';
import 'package:msf/utills/responsive.dart';

class WebsitesView extends StatefulWidget {
  const WebsitesView({
    super.key,
  });

  @override
  State<WebsitesView> createState() => _WebsitesViewState();
}

class _WebsitesViewState extends State<WebsitesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController scrollbarController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 2,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              tabAlignment: TabAlignment.start,
                              labelColor: Colors.white,
                              tabs: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "${"Websites Running".tr} (1)",
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text("${"Disable Websites".tr} (0)"),
                                ),
                              ],
                            ),
                            // active websites
                            const SizedBox(height: 16),
                            if (_selectedTabIndex == 0) ...[
                              Container(
                                width: double.infinity,
                                child: Scrollbar(
                                  controller: scrollbarController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: scrollbarController,
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: DataTable(
                                        columnSpacing: 30,
                                        border: TableBorder.all(
                                          color: Colors.white,
                                          width: 0.07,
                                        ),
                                        columns: [
                                          DataColumnTile.buildRow(
                                              title: 'Name'),
                                          DataColumnTile.buildRow(
                                              title: 'Application'),
                                          DataColumnTile.buildRow(
                                              title: 'Listens to'),
                                          DataColumnTile.buildRow(
                                              title: 'Real web server'),
                                          DataColumnTile.buildRow(
                                              title: 'Logs'),
                                          DataColumnTile.buildRow(
                                              title: 'Status'),
                                          DataColumnTile.buildRow(
                                              title: 'Mode'),
                                          DataColumnTile.buildRow(
                                              title: 'Actions'),
                                        ],
                                        rows: [
                                          DataRowTile.websiteRow(
                                            name: 'climber',
                                            application: 'www.climbersoul.cl',
                                            listenTo: '192.168.238.130',
                                            realWebServer:
                                                '142.44.241.198=>443',
                                            onTapLog: () {},
                                            status: true,
                                            onModeChanged: (p0) {},
                                            onTapEdit: () {},
                                            onTapStart: () {},
                                            onTapPause: () {},
                                            onTapDelete: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ] else if (_selectedTabIndex == 1) ...[
                              // disable websites datatable
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DataTable(
                                  columnSpacing: 30,
                                  border: TableBorder.all(
                                    color: Colors.white,
                                    width: 0.07,
                                  ),
                                  columns: [
                                    DataColumnTile.buildRow(title: 'Name'),
                                    DataColumnTile.buildRow(
                                        title: 'Application'),
                                    DataColumnTile.buildRow(
                                        title: 'Listens to'),
                                    DataColumnTile.buildRow(
                                        title: 'Real web server'),
                                    DataColumnTile.buildRow(title: 'Logs'),
                                    DataColumnTile.buildRow(title: 'Status'),
                                    DataColumnTile.buildRow(title: 'Mode'),
                                    DataColumnTile.buildRow(title: 'Actions'),
                                  ],
                                  rows: [],
                                ),
                              ),
                            ],
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
}

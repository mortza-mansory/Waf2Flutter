import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/helper/snackbar_helper.dart';
import 'package:msf/core/router/app_router.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';

import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/core/utills/responsive.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({
    super.key,
  });

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen>
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
                              indicator: const BoxDecoration(
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
                                Tab(text: "${"Websites Running".tr} (1)"),
                                Tab(text: "${"Disable Websites".tr} (0)"),
                              ],
                            ),
                            // active websites
                            const SizedBox(height: 16),
                            if (_selectedTabIndex == 0) ...[
                              SizedBox(
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
                                            onListenTap: () => Get.toNamed(
                                                AppRouter.editWebsiteRoute,
                                                arguments:
                                                    'www.climbersoul.cl'),
                                            realWebServer:
                                                '142.44.241.198=>443',
                                            onTapLog: () => Get.toNamed(
                                                AppRouter.websiteLogRoute,
                                                arguments:
                                                    'www.climbersoul.cl'),
                                            status: true,
                                            onModeChanged: (p0) {},
                                            onTapEdit: () {},
                                            onTapStart: () => SnackbarHelper()
                                                .questionSnackbar(
                                              question:
                                                  'Disable website www.morteza.com?',
                                              snackBarTitle:
                                                  'website Started'.tr,
                                              snackBarMessage:
                                                  'website www.morteza.com has been started'
                                                      .tr,
                                            ),
                                            onTapPause: () {},
                                            onTapDelete: () => SnackbarHelper()
                                                .questionSnackbar(
                                              question:
                                                  'Are you sure to delete website www.morteza.com?',
                                              snackBarTitle:
                                                  'website deleted'.tr,
                                              snackBarMessage:
                                                  'website www.morteza.com has been deleted'
                                                      .tr,
                                            ),
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
                                  rows: const [],
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

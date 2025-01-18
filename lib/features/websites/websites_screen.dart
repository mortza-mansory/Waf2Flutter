import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/helper/snackbar_helper.dart';
import 'package:msf/core/router/app_router.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/features/controllers/websites/website/websiteController.dart';
import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({super.key});

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController scrollbarController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final WebsiteController websiteController = Get.find<WebsiteController>();
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
    websiteController.fetchWebsites();
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Obx(() {
          // Check if websites are being loaded
          if (websiteController.websites.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
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
                      Tab(text: "${"Websites Running".tr} (${websiteController.websites.length})"),
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
                                DataColumnTile.buildRow(title: 'Listens to'),
                                DataColumnTile.buildRow(title: 'Real web server'),
                                DataColumnTile.buildRow(title: 'Logs'),
                                DataColumnTile.buildRow(title: 'Status'),
                                DataColumnTile.buildRow(title: 'Mode'),
                                DataColumnTile.buildRow(title: 'Actions'),
                              ],
                              rows: websiteController.websites
                                  .map((website) => DataRowTile.websiteRow(
                                name: website.name,
                                application: website.url,
                                listenTo: '192.168.238.130', // Dummy data, replace with real
                                onListenTap: () => Get.toNamed(AppRouter.editWebsiteRoute, arguments: website.url),
                                realWebServer: '142.44.241.198=>443', // Dummy data, replace with real
                                onTapLog: () => Get.toNamed(AppRouter.websiteLogRoute, arguments: website.url),
                                status: true, // Update with real status if needed
                                onModeChanged: (p0) {},
                                onTapEdit: () {},
                                onTapStart: () {
                                  SnackbarHelper().questionSnackbar(
                                    question: 'Disable website ${website.name}?',
                                    snackBarTitle: 'Website Started'.tr,
                                    snackBarMessage: 'Website ${website.name} has been started'.tr,
                                  );
                                },
                                onTapPause: () {},
                                onTapDelete: () {
                                  SnackbarHelper().questionSnackbar(
                                    question: 'Are you sure to delete website ${website.name}?',
                                    snackBarTitle: 'Website Deleted'.tr,
                                    snackBarMessage: 'Website ${website.name} has been deleted'.tr,
                                  );
                                },
                              ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ] else if (_selectedTabIndex == 1) ...[
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
                          DataColumnTile.buildRow(title: 'Application'),
                          DataColumnTile.buildRow(title: 'Listens to'),
                          DataColumnTile.buildRow(title: 'Real web server'),
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
            );
          }
        }),
      ],
    );
  }
}

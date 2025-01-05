import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:msf/core/component/page_builder.dart';

import 'package:msf/core/utills/colorconfig.dart';

import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/features/websites/edit_tabs/certificate_tab.dart';
import 'package:msf/features/websites/edit_tabs/expert_config_tab.dart';
import 'package:msf/features/websites/edit_tabs/http_tab.dart';
import 'package:msf/features/websites/edit_tabs/rewrite_tab.dart';
import 'package:msf/features/websites/edit_tabs/waf_protection_tab.dart';

class EditWebsite extends StatefulWidget {
  const EditWebsite({
    super.key,
  });

  @override
  State<EditWebsite> createState() => _EditWebsiteState();
}

class _EditWebsiteState extends State<EditWebsite>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController scrollbarController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final String title = Get.arguments ?? "";
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();

    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    scrollbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        title != ""
            ? Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Scrollbar(
                controller: scrollbarController,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: scrollbarController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TabBar(
                      controller: _tabController,
                      tabAlignment: TabAlignment.center,
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
                        tabMaker("WAF Protection", Icons.shield),
                        tabMaker("HTTP/HTTPS", Icons.display_settings_rounded),
                        tabMaker("Certificates", Icons.circle),
                        tabMaker("SSL", Icons.lock),
                        tabMaker("Rewrite", Icons.auto_fix_normal_sharp),
                        tabMaker("Expert Configuration",
                            Icons.build_circle_outlined),
                      ],
                    ),
                  ),
                ),
              ),

              // active websites
              const SizedBox(height: 16),
              if (_selectedTabIndex == 0) ...[
                WafProtectionTab()
              ] else if (_selectedTabIndex == 1) ...[
                const HttpTab()
              ] else if (_selectedTabIndex == 2) ...[
                const CertificateTab()
              ] else if (_selectedTabIndex == 3) ...[
                const Text("SSL Parameters"),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "You must save the certificate and then ",
                    style:
                        TextStyle(color: Get.theme.primaryColor, fontSize: 14),
                    children: [
                      TextSpan(
                        text: "reload",
                        style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        style: TextStyle(
                            color: Get.theme.primaryColor, fontSize: 14),
                        text: " this page to modify the SSL Configuration",
                      ),
                    ],
                  ),
                )
              ] else if (_selectedTabIndex == 4) ...[
                const RewriteTab()
              ] else if (_selectedTabIndex == 5) ...[
                const ExpertConfigTab()
              ]
            ],
          ),
        ),
      ],
    );
  }

  Tab tabMaker(String title, IconData icon) => Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 5),
            Text(title)
          ],
        ),
      );
}

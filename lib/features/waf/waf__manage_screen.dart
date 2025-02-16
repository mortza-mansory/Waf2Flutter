import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/services/unit/api/HttpService.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/features/dashboard/component/CircleChar.dart';

import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';
import 'package:msf/core/utills/responsive.dart';

class WafManagerScreen extends StatefulWidget {
  const WafManagerScreen({super.key});

  @override
  State<WafManagerScreen> createState() => _ManageWafScreenState();
}

class _ManageWafScreenState extends State<WafManagerScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final ScrollController scrollbarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WafActions,
              const SizedBox(width: 10, height: 10),
              pendingAppSection
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: WafActions),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: WafActions),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
        ),
      ],
    );
  }
  Widget get WafActions {
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
            "Waf Actions",
            maxLines: 1,
          ),
          const SizedBox(height: 15),
          // Circular chart showing WAF status via a FutureBuilder
          FutureBuilder<bool>(
            future: checkModSecurityStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircleChart(
                  circleColor: Colors.grey[500]!,
                  mainText: "Loading",
                  subText: "Checking status...",
                );
              } else if (snapshot.hasError) {
                return CircleChart(
                  circleColor: Colors.redAccent,
                  mainText: "Error",
                  subText: "Unable to get status",
                );
              } else if (snapshot.hasData) {
                bool isOn = snapshot.data!;
                if (isOn) {
                  return CircleChart(
                    circleColor: Colors.greenAccent,
                    mainText: "Safe",
                    subText: "WAF is ON!",
                  );
                } else {
                  return CircleChart(
                    circleColor: Colors.redAccent,
                    mainText: "Unsafe",
                    subText: "WAF is OFF!",
                  );
                }
              }
              // Fallback
              return CircleChart(
                circleColor: Colors.grey[500]!,
                mainText: "Loading",
                subText: "Checking status...",
              );
            },
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconbuttonWidget(
                  backColor: Colors.yellow[100]!,
                  iconColor: Colors.yellow[900]!,
                  titleColor: Colors.yellow[900]!,
                  title: "Check Confg",
                  icon: Icons.check,
                  onPressed: () async {
                    bool status = await checkModSecurityStatus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(status ? "WAF is ON!" : "WAF is OFF!"),
                      ),
                    );
                    setState(() {});
                  },
                ),
                CustomIconbuttonWidget(
                  backColor: Colors.green[100]!,
                  iconColor: Colors.green[900]!,
                  titleColor: Colors.green[900]!,
                  title: "Start Engine",
                  icon: Icons.play_arrow,
                  onPressed: () async {
                    bool result = await toggleModSecurity("on");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result
                            ? "WAF started successfully!"
                            : "Failed to start WAF"),
                      ),
                    );
                    setState(() {});
                  },
                ),
                CustomIconbuttonWidget(
                  backColor: Colors.redAccent[100]!,
                  iconColor: Colors.red[900]!,
                  titleColor: Colors.red[900]!,
                  title: "Stop Engine",
                  icon: Icons.stop,
                  onPressed: () async {
                    bool result = await toggleModSecurity("off");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result
                            ? "WAF stopped successfully!"
                            : "Failed to stop WAF"),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get pendingAppSection => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Scrollbar(
            controller: scrollbarController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: scrollbarController,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AutoSizeText(
                      "Waf Pending to preview",
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
                        DataColumnTile.buildRow(title: 'Name'),
                        DataColumnTile.buildRow(title: 'Application Url'),
                        DataColumnTile.buildRow(title: 'Status'),
                        DataColumnTile.buildRow(title: 'Author'),
                        DataColumnTile.buildRow(title: 'Actions'),
                      ],
                      rows: [
                        DataRowTile.addWebsiteRow(
                          name: 'climber',
                          applicationUrl: 'www.climbersoul.cl',
                          status: "Ready to deploy",
                          author: "admin",
                          onTapDelete: () {},
                          onTapDeploy: () {},
                        ),
                        DataRowTile.addWebsiteRow(
                          name: 'climber',
                          applicationUrl: 'www.climbersoul.cl',
                          status: "Ready to deploy",
                          author: "admin",
                          onTapDelete: () {},
                          onTapDeploy: () {},
                        ),
                        DataRowTile.addWebsiteRow(
                          name: 'climber',
                          applicationUrl: 'www.climbersoul.cl',
                          status: "Ready to deploy",
                          author: "admin",
                          onTapDelete: () {},
                          onTapDeploy: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/features/controllers/settings/IdleController.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';

import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';
import 'package:msf/core/utills/responsive.dart';

class ManageNginxScreen extends StatefulWidget {
  const ManageNginxScreen({super.key});

  @override
  State<ManageNginxScreen> createState() => _ManageNginxScreenState();
}

class _ManageNginxScreenState extends State<ManageNginxScreen> {
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
              nginxActions,
              const SizedBox(width: 10, height: 10),
              pendingAppSection
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: nginxActions),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: nginxActions),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
        ),
      ],
    );
  }

  Widget get nginxActions {
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
          SizedBox(
            height: 35,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomIconbuttonWidget(
                  backColor: Colors.yellow[100]!,
                  iconColor: Colors.yellow[900]!,
                  titleColor: Colors.yellow[900]!,
                  title: "Check Confg",
                  icon: Icons.check,
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  backColor: Colors.blue[100]!,
                  iconColor: Colors.blue[900]!,
                  titleColor: Colors.blue[900]!,
                  title: "Reload",
                  icon: Icons.autorenew,
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  backColor: Colors.green[100]!,
                  iconColor: Colors.green[900]!,
                  titleColor: Colors.green[900]!,
                  title: "Start Engine",
                  icon: Icons.play_arrow,
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                CustomIconbuttonWidget(
                  backColor: Colors.redAccent[100]!,
                  iconColor: Colors.red[900]!,
                  titleColor: Colors.red[900]!,
                  title: "Stop Engine",
                  icon: Icons.stop,
                  onPressed: () {},
                ),
              ],
            ),
          )
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
                      "Nginx Pending to preview",
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

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/responsive.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final ScrollController scrollbarController = ScrollController();
  final TextEditingController applicationTextController =
      TextEditingController();
  final TextEditingController urlTextController = TextEditingController();
  @override
  void dispose() {
    applicationTextController.dispose();
    urlTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addNewAppSection,
              const SizedBox(width: 10, height: 10),
              pendingAppSection
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: addNewAppSection),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: addNewAppSection),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
        ),
      ],
    );
  }

  Widget get addNewAppSection {
    final Size size = MediaQuery.of(context).size;
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
            "Add New Application",
            maxLines: 1,
          ),
          const SizedBox(height: 15),
          const AutoSizeText(
            "Application Name",
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          DashboardTextfield(
            textEditingController: applicationTextController,
            hintText: "EX: Customer_name (without space)",
          ),
          const SizedBox(height: 10),
          const AutoSizeText(
            "Application Url",
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          DashboardTextfield(
            textEditingController: applicationTextController,
            hintText: "www.customer.com",
          ),
          const SizedBox(
            height: 15,
            width: 15,
          ),
          SizedBox(
            width: size.width / 7,
            child: CustomIconbuttonWidget(
              icon: Icons.save_outlined,
              backColor: Colors.blue,
              title: "Save".tr,
              onPressed: () {},
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
                      "Applications Pending to preview",
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

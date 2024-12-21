import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/controllers/settings/IdleController.dart';
import 'package:msf/controllers/settings/MenuController.dart';
import 'package:msf/screens/component/Header.dart';
import 'package:msf/screens/component/SideBar.dart';
import 'package:msf/screens/component/widgets/custom_iconbutton.dart';
import 'package:msf/screens/component/widgets/dashboard_textfield.dart';
import 'package:msf/screens/websites/components/data_column_tile.dart';
import 'package:msf/screens/websites/components/data_row_tile.dart';
import 'package:msf/screens/websites/websites_view.dart';
import 'package:msf/utills/colorconfig.dart';
import 'package:msf/utills/responsive.dart';

class AddWebsiteView extends StatefulWidget {
  AddWebsiteView({super.key});

  @override
  State<AddWebsiteView> createState() => _AddWebsiteViewState();
}

class _AddWebsiteViewState extends State<AddWebsiteView> {
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
    final Size size = MediaQuery.of(context).size;
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                      Responsive(
                        mobile: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            addNewAppSection,
                            SizedBox(width: 10, height: 10),
                            pendingAppSection
                          ],
                        ),
                        tablet: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 2, child: addNewAppSection),
                            SizedBox(width: 10, height: 10),
                            Expanded(flex: 3, child: pendingAppSection),
                          ],
                        ),
                        desktop: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 2, child: addNewAppSection),
                            SizedBox(width: 10, height: 10),
                            Expanded(flex: 3, child: pendingAppSection),
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
          AutoSizeText(
            "Add New Application",
            maxLines: 1,
          ),
          SizedBox(height: 15),
          AutoSizeText(
            "Application Name",
            maxLines: 1,
          ),
          SizedBox(height: 5),
          DashboardTextfield(
            textEditingController: applicationTextController,
            hintText: "EX: Customer_name (without space)",
          ),
          SizedBox(height: 10),
          AutoSizeText(
            "Application Url",
            maxLines: 1,
          ),
          SizedBox(height: 5),
          DashboardTextfield(
            textEditingController: applicationTextController,
            hintText: "www.customer.com",
          ),
          SizedBox(
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
        child: Container(
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
                    AutoSizeText(
                      "Applications Pending to preview",
                      maxLines: 1,
                    ),
                    SizedBox(height: 10),
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

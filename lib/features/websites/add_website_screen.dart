import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/models/website.dart';
import 'package:msf/core/utills/responsive.dart';
import 'package:msf/features/controllers/websites/uploads/UploadController.dart';
import 'package:msf/features/controllers/websites/website/websiteController.dart';
import 'package:msf/features/websites/components/data_column_tile.dart';
import 'package:msf/features/websites/components/data_row_tile.dart';

class AddWebsiteScreen extends StatefulWidget {
  AddWebsiteScreen({Key? key}) : super(key: key);

  @override
  _AddWebsiteScreenState createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UploadController uploadController = Get.put(UploadController());
  final WebsiteController websiteController = Get.put(WebsiteController());
  final TextEditingController applicationTextController =
      TextEditingController();
  final TextEditingController urlTextController = TextEditingController();
  final ScrollController scrollbarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addNewAppSection(context),
              const SizedBox(width: 10, height: 10),
              pendingAppSection,
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: addNewAppSection(context)),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: addNewAppSection(context)),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: pendingAppSection),
            ],
          ),
        ),
      ],
    );
  }

  Widget addNewAppSection(BuildContext context) {
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
          const AutoSizeText("Add New Application", maxLines: 1),
          const SizedBox(height: 15),
          const AutoSizeText("Application Name", maxLines: 1),
          const SizedBox(height: 5),
          DashboardTextfield(
            textEditingController: applicationTextController,
            hintText: "EX: Customer_name (without space)",
          ),
          const SizedBox(height: 10),
          const AutoSizeText("Application Url", maxLines: 1),
          const SizedBox(height: 5),
          DashboardTextfield(
            textEditingController: urlTextController,
            hintText: "www.customer.com",
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: size.width / 7,
            child: CustomIconbuttonWidget(
              icon: Icons.save_outlined,
              backColor: Colors.blue,
              title: "Save".tr,
              onPressed: () async {
                //   String selectedFilePath = websiteController.selectedFilePath ?? '';
                // if (selectedFilePath.isNotEmpty) {
                Website website = Website(
                  name: applicationTextController.text,
                  url: urlTextController.text,
                  zipPath: '',
                  status: 'Waiting for zip',
                  author: "admin",
                  initStatus: false,
                );
                websiteController.addWebsite(
                  website.name,
                  website.url,
                  website.zipPath,
                );

                //   ScaffoldMessenger.of(context).showSnackBar(
                //  SnackBar(content: Text('Website saved with selected file!')),
                //     );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget get pendingAppSection {
    return Obx(() {
      if (websiteController.websites.isEmpty) {
        return const Text("No applications available.");
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.onSecondary,
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
                        DataColumnTile.buildRow(title: 'Actions'),
                      ],
                      rows: websiteController.websites.map((website) {
                        return DataRow(
                          cells: [
                            DataCell(Text(website.name)),
                            DataCell(Text(website.url)),
                            DataCell(Obx(() {
                              return Text(
                                  website.status.value);
                            })),
                            DataCell(
                                Row(
                              children: [
                                Tooltip(
                                  message: 'Upload this website to the server',
                                  child: IconButton(
                                    icon: const Icon(Icons.upload),
                                    onPressed: () {
                                      if (website.status == 'Waiting for zip') {
                                        String applicationName = applicationTextController.text;
                                        if (applicationName.isEmpty) {
                                          Get.snackbar("Error", "Please enter an application name.");
                                          return;
                                        }

                                        uploadController.uploadZipFile(
                                          applicationName: applicationName,
                                          website: website,
                                        );
                                      } else {
                                        Get.snackbar("Error", "Cannot upload. Current status: ${website.status}");
                                      }
                                    },
                                  ),
                                ),
                                Tooltip(
                                  message: 'Deploy this website to the server',
                                  child: IconButton(
                                    icon: const Icon(Icons.cloud_upload),
                                    onPressed: () {
                                      if (website.status== 'Deployed') {
                                        Get.snackbar("Error", "This website is already deployed.");
                                        return;
                                      }
                                      if (website.status == 'Ready to deploy!') {
                                        websiteController.updateStatus(website, 'Deploying...');
                                        websiteController.deployWebsite(website);

                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "Cannot deploy. Current status: ${website.status}",
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Tooltip(
                                  message:
                                      'Delete this website from the pending list',
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      websiteController.removeWebsite(website);
                                    },
                                  ),
                                ),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

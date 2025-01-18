import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/page_builder.dart';
import 'package:msf/core/component/widgets/custom_dropdown.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/colorconfig.dart';
import 'package:msf/features/controllers/settings/MenuController.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';

import 'package:msf/core/utills/responsive.dart';

class AddVirtualIPScreen extends StatefulWidget {
  const AddVirtualIPScreen({super.key});

  @override
  State<AddVirtualIPScreen> createState() => _AddVirtualIPScreenState();
}

class _AddVirtualIPScreenState extends State<AddVirtualIPScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Menu_Controller menuController = Get.find<Menu_Controller>();
  final ScrollController scrollbarController = ScrollController();
  TextEditingController ipAddressTextcontroller = TextEditingController();
  TextEditingController netmaskTextcontroller = TextEditingController();

  @override
  void initState() {
    netmaskTextcontroller.text = "255.255.255.0";
    super.initState();
  }

  @override
  void dispose() {
    ipAddressTextcontroller.dispose();
    netmaskTextcontroller.dispose();
    super.dispose();
  }

  final List<String> interfaces = [
    "ens-33",
  ];
  @override
  Widget build(BuildContext context) {
    return PageBuilder(
      sectionWidgets: [
        Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createIps,
              const SizedBox(width: 10, height: 10),
              addedIps
            ],
          ),
          tablet: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: createIps),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: addedIps),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: createIps),
              const SizedBox(width: 10, height: 10),
              Expanded(flex: 3, child: addedIps),
            ],
          ),
        ),
      ],
    );
  }

  Widget get createIps {
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
            "IP Address",
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          DashboardTextfield(
            textEditingController: ipAddressTextcontroller,
            maxLength: 16,
            hintText: "192.168.1.1",
            inputType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          const AutoSizeText(
            "Netmask",
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          DashboardTextfield(
            textEditingController: netmaskTextcontroller,
            maxLength: 16,
            inputType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const AutoSizeText(
                "Interface:",
                maxLines: 1,
              ),
              SizedBox(width: 10),
              CustomDropdownWidget(
                list: interfaces,
                value: interfaces[0],
                onchangeValue: (value) {},
              )
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 30,
            width: 100,
            child: CustomIconbuttonWidget(
              backColor: primaryColor,
              onPressed: () {},
              title: "Save",
            ),
          )
        ],
      ),
    );
  }

  Widget get addedIps => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AutoSizeText(
                  "IPs Added",
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                addedIpMaker("inet6::1/128 scope host noprefixroute"),
                addedIpMaker("inet6::1/128 scope host noprefixroute"),
                addedIpMaker(
                    "inet 192.168.70.157/24 brd 192.168.70.255 scope global dynamic ens33"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
  Widget addedIpMaker(String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•'),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              textAlign: TextAlign.justify,
              text,
            ),
          ),
        ],
      );
}

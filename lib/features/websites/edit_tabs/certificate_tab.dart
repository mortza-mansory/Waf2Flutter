import 'package:flutter/material.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/colorconfig.dart';

class CertificateTab extends StatefulWidget {
  const CertificateTab({super.key});

  @override
  State<CertificateTab> createState() => _CertificateTabState();
}

class _CertificateTabState extends State<CertificateTab> {
  TextEditingController certificateTextController = TextEditingController();
  TextEditingController chainTextController = TextEditingController();
  TextEditingController privateKeyTextController = TextEditingController();

  @override
  void dispose() {
    certificateTextController.dispose();
    chainTextController.dispose();
    privateKeyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        sectionMaker("Certificate", certificateTextController),
        const SizedBox(height: 15),
        sectionMaker("Chain", chainTextController),
        const SizedBox(height: 15),
        sectionMaker("Private Key", privateKeyTextController),
        const SizedBox(height: 15),
        SizedBox(
          width: 100,
          child: CustomIconbuttonWidget(
            backColor: primaryColor,
            onPressed: () {},
            icon: Icons.save,
            title: "Save",
          ),
        ),
      ],
    );
  }

  Widget sectionMaker(
    String title,
    TextEditingController textController,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 5),
            DashboardTextfield(
              textEditingController: textController,
              maxLines: 20,
              inputType: TextInputType.multiline,
            ),
          ],
        ),
      );
}

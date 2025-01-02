import 'package:flutter/material.dart';
import 'package:msf/core/component/widgets/custom_iconbutton.dart';
import 'package:msf/core/component/widgets/dashboard_textfield.dart';
import 'package:msf/core/utills/colorconfig.dart';

class ExpertConfigTab extends StatefulWidget {
  const ExpertConfigTab({super.key});

  @override
  State<ExpertConfigTab> createState() => _ExpertConfigTabState();
}

class _ExpertConfigTabState extends State<ExpertConfigTab> {
  TextEditingController nginxTextController = TextEditingController();
  TextEditingController modsecurityTextController = TextEditingController();

  @override
  void dispose() {
    nginxTextController.dispose();
    modsecurityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        sectionMaker("Nginx Configuration", nginxTextController),
        const SizedBox(height: 15),
        sectionMaker("Modsecurity Configuration", modsecurityTextController),
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

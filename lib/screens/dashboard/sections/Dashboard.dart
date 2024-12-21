import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/screens/component/EndSection.dart';
import 'package:msf/screens/dashboard/component/AttacksPerApplicationTable.dart';
import 'package:msf/screens/dashboard/component/InfoCardGridView.dart';
import 'package:msf/screens/dashboard/component/ViewersChart.dart';
import 'package:msf/screens/dashboard/sections/StatusSection.dart';
import 'package:msf/utills/responsive.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Dashboard".tr,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Responsive(
                    mobile: InfoCardGridView(
                      crossAxisCount: size.width < 650 ? 2 : 4,
                      childAspectRatio: size.width < 650 ? 1.3 : 1,
                    ),
                    tablet: InfoCardGridView(),
                    desktop: InfoCardGridView(
                      childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Responsive(
                    mobile: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: AttacksPerApplicationTable(
                        secondryColor: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    tablet: AttacksPerApplicationTable(
                      secondryColor: Theme.of(context).secondaryHeaderColor,
                    ),
                    desktop: AttacksPerApplicationTable(
                      secondryColor: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  if (Responsive.isMobile(context))
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: StatusSection(),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 2,
                child: StatusSection(),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Responsive(
          mobile: Viewers(),
          tablet: Viewers(),
          desktop: Viewers(),
        ),
        const SizedBox(
          height: 16,
        ),
        const Responsive(
          mobile: EndSection(),
          tablet: EndSection(),
          desktop: EndSection(),
        ),
      ],
    );
  }
}

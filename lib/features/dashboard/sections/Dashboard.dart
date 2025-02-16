import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msf/core/component/EndSection.dart';
import 'package:msf/features/dashboard/component/RequestsBars.dart';
import 'package:msf/features/dashboard/component/attacks_perapplication_table.dart';
import 'package:msf/features/dashboard/component/Info_card_gridview.dart';
import 'package:msf/features/dashboard/component/viewers_chart.dart';
import 'package:msf/features/dashboard/sections/StatusSection.dart';
import 'package:msf/core/utills/responsive.dart';

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
                    height: 24,
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
                        secondryColor:
                        Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                    tablet: AttacksPerApplicationTable(
                      secondryColor:
                      Theme.of(context).secondaryHeaderColor,
                    ),
                    desktop: AttacksPerApplicationTable(
                      secondryColor:
                      Theme.of(context).secondaryHeaderColor,
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

        Responsive(
          mobile: Column(
            children: const [
              Viewers(),
              SizedBox(height: 16),
              RequestsBars(),
            ],
          ),
          tablet: Row(
            children: const [
              Expanded(child: Viewers()),
              SizedBox(width: 16),
              Expanded(child: RequestsBars()),
            ],
          ),
          desktop: Row(
            children: const [
              Expanded(child: Viewers()),
              SizedBox(width: 16),
              Expanded(child: RequestsBars()),
            ],
          ),
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

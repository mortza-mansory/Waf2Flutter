import 'package:flutter/material.dart';
import 'package:msf/core/component/Header.dart';
import 'package:msf/core/component/SideBar.dart';
import 'package:msf/core/utills/responsive.dart';

class PageBuilder extends StatefulWidget {
  final List<Widget> sectionWidgets;
  const PageBuilder({super.key, required this.sectionWidgets});

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final sideBar = const SideBar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,  // Only used once in PageBuilder
        drawer: !Responsive.isDesktop(context)
            ? const Drawer(
          child: SideBar(),
        )
            : null,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: sideBar,
              ),
            Expanded(
              flex: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Header(scaffoldKey: scaffoldKey),  // Pass the scaffoldKey once
                      const SizedBox(height: 16),
                      ...widget.sectionWidgets,
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
}

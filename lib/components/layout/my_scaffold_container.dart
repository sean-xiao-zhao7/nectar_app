import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';

class MyScaffoldContainer extends StatelessWidget {
  final Widget? child;
  final String title;
  final List<Widget>? appBarActions;
  final Widget? appBarLead;
  const MyScaffoldContainer(
      {super.key,
      required this.child,
      required this.title,
      this.appBarLead,
      this.appBarActions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: MyAppBar(
          title: title,
          appBarLead: appBarLead,
          appBarActions: appBarActions,
        ),
        body: Container(padding: EdgeInsets.all(20), child: child));
  }
}

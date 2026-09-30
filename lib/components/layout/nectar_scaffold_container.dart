import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/nectar_drawer.dart';
import 'package:nectar_app/components/layout/nectar_app_bar.dart';

// Custom scaffold
//
// Uses custom drawer, app bar, text style.
// Gets app bar children to be passed.
class NectarScaffoldContainer extends StatelessWidget {
  final Widget? child;
  final String title;
  final List<Widget>? appBarActions;
  final Widget? appBarLead;
  const NectarScaffoldContainer({
    super.key,
    this.appBarLead,
    this.appBarActions,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NectarDrawer(),
        appBar: NectarAppBar(
          title: title,
          appBarLead: appBarLead,
          appBarActions: appBarActions,
        ),
        body: DefaultTextStyle.merge(
            style: TextStyle(fontSize: 16),
            child: Container(padding: EdgeInsets.all(20), child: child)));
  }
}

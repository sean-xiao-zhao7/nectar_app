import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/nectar_drawer.dart';
import 'package:nectar_app/components/layout/nectar_app_bar.dart';

// Custom scaffold
//
// Uses custom drawer, app bar, text style.
// Gets app bar children to be passed.
class NectarScaffoldContainer extends StatelessWidget {
  final String title;
  final Widget? child, appBarLead;
  final List<Widget>? appBarActions;
  final double? padding;

  const NectarScaffoldContainer({
    super.key,
    this.appBarLead,
    this.appBarActions,
    this.padding,
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
            style: TextStyle(fontSize: 18),
            child: Container(
                padding: EdgeInsets.all(padding ?? 18), child: child)));
  }
}

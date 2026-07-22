import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';

class MyScaffoldContainer extends StatelessWidget {
  final Widget? child;
  final String title;
  const MyScaffoldContainer(
      {super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: MyAppBar(
          title: title,
        ),
        body: Container(padding: EdgeInsets.all(20), child: child));
  }
}

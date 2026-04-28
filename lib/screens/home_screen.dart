import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[MyRegularText('Welcome to Nectar!')],
        ),
      ),
    );
  }
}

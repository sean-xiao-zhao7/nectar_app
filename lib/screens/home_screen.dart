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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: <Widget>[
                MyRegularText(
                  'Welcome to Nectar!',
                  fontWeight: FontWeight.w600,
                ),
                MyRegularText(
                  'Sign in to your account by tapping the top left drawer, then "Sign in".',
                  fontSize: 16,
                ),
                MyRegularText(
                  'Or if you don\'t already have an account, sign up with us today using the "Sign up" option.',
                  fontSize: 16,
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(bottom: 50),
              child: MyRegularText('\u00a9 2026 Nectar Inc.')),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_large_text.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/auth_helper.dart';
import 'package:nectar_app/models/nectar_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshotAuth) {
          Widget widgetTree = Center(child: CircularProgressIndicator());
          if (snapshotAuth.connectionState == ConnectionState.active &&
              !snapshotAuth.hasData) {
            widgetTree = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 20,
                children: [
                  MyLargeText(
                    'Welcome to Nectar!',
                  ),
                  MyRegularText(
                      'Sign in to your account by tapping the top left drawer, then "Log in".'),
                  MyRegularText(
                      'Or if you don\'t already have an account, sign up with us today using the "Sign up" option.'),
                ]);
          } else if (snapshotAuth.connectionState == ConnectionState.active &&
              snapshotAuth.hasData) {
            widgetTree = FutureBuilder<NectarUser>(
                future: fetchUserInfo(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<NectarUser> snapshotUserInfo) {
                  if (snapshotUserInfo.connectionState ==
                          ConnectionState.done &&
                      snapshotUserInfo.hasData) {
                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 30,
                        children: [
                          MyLargeText(
                            'Welcome to Nectar!',
                            textAlign: TextAlign.center,
                          ),
                          MyRegularText(
                              'Access your cards from the drawer menu on the left.'),
                          // MyRegularText(
                          //     'For help, select the "Help" option from the drawer on the left.'),
                          MyRegularText(
                              'We hope you enjoy your experience with Nectar!'),
                        ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }

          return Scaffold(
              drawer: MyDrawer(),
              appBar: MyAppBar(),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ]),
                        child: widgetTree),
                    Container(
                        padding: EdgeInsets.only(bottom: 50),
                        child: MyRegularText('\u00a9 2026 Nectar Inc.'))
                  ]));
        });
  }
}

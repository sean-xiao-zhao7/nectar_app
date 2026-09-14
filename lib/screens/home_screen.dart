import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/layout/nectar_footer.dart';
import 'package:nectar_app/components/layout/nectar_divider.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
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
                  NectarLargeText(
                    'Welcome to Nectar!',
                  ),
                  NectarRegularText(
                      'Sign in to your account by tapping the top left drawer, then "Log in".'),
                  NectarRegularText(
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
                    return ListView(children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 30,
                          children: [
                            NectarLargeText(
                              'Welcome to Nectar!',
                              textAlign: TextAlign.center,
                            ),
                            NectarRegularText(
                                'Please use the menu to the top left to access the various features of Nectar.'),
                            NectarDivider(),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'Cards Collection',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' contains all cards you have saved.'),
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'My Cards',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      ' contains cards representing yourself that you want to share with others.'),
                            ])),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: 'Add A New Card',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      ' allows you to scan and save a new card.'),
                            ])),
                            NectarDivider(),
                            Text('We hope you enjoy using Nectar!')
                          ])
                    ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }

          return NectarScaffoldContainer(
              title: 'Nectar',
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ]),
                          child: widgetTree),
                    ),
                    NectarFooter()
                  ]));
        });
  }
}

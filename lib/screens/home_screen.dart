import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar_app/components/buttons/nectar_regular_button.dart';

import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/layout/nectar_footer.dart';
import 'package:nectar_app/components/layout/nectar_divider.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/helpers/auth_helper.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/models/nectar_user.dart';
import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/auth/register_screen.dart';
import 'package:nectar_app/screens/help/help_home_screen.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  NectarLargeText(
                    'Welcome to Nectar',
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  NectarLargeText(
                    'Your virtual cards collection.',
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  NectarDivider(),
                  NectarRegularButton(
                      label: 'Log in',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      labelTextColor: Theme.of(context).colorScheme.tertiary,
                      onPressed: () => nectarNavigate(context, LoginScreen())),
                  // NectarDivider(),
                  NectarRegularButton(
                      label: 'Sign up',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      labelTextColor: Theme.of(context).colorScheme.tertiary,
                      iconData: Icons.mail_sharp,
                      onPressed: () =>
                          nectarNavigate(context, RegisterScreen())),
                  NectarDivider(),
                  SizedBox(
                    height: 100,
                  ),
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 20,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: NectarLargeText(
                                'Welcome to Nectar',
                                fontSize: 20,
                              ),
                            ),
                            NectarRegularText(
                                'Please access the various features of Nectar from the top left menu.'),
                            NectarDivider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                NectarLargeText('Cards Collection'),
                                Text('Contains the cards you have saved.'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                NectarLargeText('My Cards'),
                                Text(
                                    'Contains the cards with your own information.'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                NectarLargeText('Add A New Card'),
                                Text('Allows you to add a new card.'),
                              ],
                            ),
                            NectarDivider(),
                            Text('We hope you enjoy using Nectar.'),
                            Text(
                                'Please visit the help section if you have any questions.')
                          ])
                    ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }

          return NectarScaffoldContainer(
              title: 'Home',
              appBarActions: [
                IconButton(
                    onPressed: () =>
                        {nectarNavigate(context, HelpHomeScreen())},
                    icon: Icon(
                      Icons.help_sharp,
                      size: 26,
                    ))
              ],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
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

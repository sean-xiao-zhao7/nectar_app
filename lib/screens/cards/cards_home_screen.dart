import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar_app/components/buttons/my_regular_button.dart';

import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_large_text.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';

import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';

import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/cards/add_single_card_screen.dart';

class CardsHomeScreen extends StatefulWidget {
  const CardsHomeScreen({super.key});

  @override
  State<CardsHomeScreen> createState() => _CardsHomeScreenState();
}

class _CardsHomeScreenState extends State<CardsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshotAuth) {
          Widget widgetTree = Center(child: CircularProgressIndicator());
          if (snapshotAuth.connectionState == ConnectionState.done &&
              !snapshotAuth.hasData) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const LoginScreen(),
              ),
            );
          } else if (snapshotAuth.connectionState == ConnectionState.active &&
              snapshotAuth.hasData) {
            widgetTree = FutureBuilder<List<NectarCard>>(
                future: fetchUserAllCards(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NectarCard>> snapshotCards) {
                  if (snapshotCards.connectionState == ConnectionState.done &&
                      snapshotCards.hasData) {
                    List<Widget> children = [];
                    if (snapshotCards.data!.isEmpty) {
                      children = [
                        MyLargeText(
                          'You have no cards yet.',
                          textAlign: TextAlign.center,
                        ),
                        MyRegularButton(
                            label: 'Add a card',
                            hasDelay: false,
                            iconData: Icons.add,
                            onPressed: () =>
                                myNavigate(context, AddSingleCardScreen()))
                      ];
                    } else {
                      children = [
                        MyLargeText('Here are your cards.'),
                        MyRegularText(
                            'You can manage each card by tapping on it.'),
                      ];
                    }

                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 20,
                        children: children);
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                });
          }

          return Scaffold(
              drawer: MyDrawer(),
              appBar: MyAppBar(
                title: 'My Cards',
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
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
                        child: MyRegularText(
                          '\u00a9 2026 Nectar Inc.',
                        ))
                  ]));
        });
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/buttons/my_regular_button.dart';
import 'package:nectar_app/components/cards/cards_list_view.dart';
import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/layout/my_scaffold_container.dart';
import 'package:nectar_app/components/text/my_large_text.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/cards/add_single_card_screen.dart';

class CardsCollectionScreen extends StatefulWidget {
  const CardsCollectionScreen({super.key});

  @override
  State<CardsCollectionScreen> createState() => _CardsCollectionScreenState();
}

class _CardsCollectionScreenState extends State<CardsCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    // first streambuilder fetches user auth
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshotAuth) {
          // widgetTree is the dynamic content on the screen based on state
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
            // second futurebuilder fetches card list
            widgetTree = FutureBuilder<List<NectarCard>>(
                future: fetchUserAllCards(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NectarCard>> snapshotCards) {
                  // switch display elements based on cards
                  if (snapshotCards.connectionState == ConnectionState.done &&
                      snapshotCards.hasData) {
                    if (snapshotCards.data!.isEmpty) {
                      return MyContainer(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 20,
                              children: [
                            MyLargeText(
                              'You have no cards yet.',
                              textAlign: TextAlign.center,
                            ),
                            MyRegularButton(
                                label: 'Add a card',
                                hasDelay: false,
                                iconData: Icons.add,
                                onPressed: () =>
                                    myNavigate(context, AddSingleCardScreen())),
                          ]));
                    } else {
                      return CardsListView(cardsList: snapshotCards.data!);
                    }
                  } else {
                    return MyContainer(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()]));
                  }
                });
          }

          return MyScaffoldContainer(
              title: 'Cards Collection',
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widgetTree,
                    Container(
                        padding: EdgeInsets.only(bottom: 50),
                        child: MyRegularText(
                          '\u00a9 2026 Nectar Inc.',
                        ))
                  ]));
        });
  }
}

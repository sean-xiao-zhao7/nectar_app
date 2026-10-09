import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/auth/logout_screen.dart';
import 'package:nectar_app/screens/auth/register_screen.dart';
import 'package:nectar_app/screens/cards/add_single_card_screen.dart';
import 'package:nectar_app/screens/cards/cards_collection_screen.dart';
import 'package:nectar_app/screens/cards/my_cards_screen.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/screens/help/help_home_screen.dart';

/// The main drawer
///
/// Has a profile section at top.
/// Then a column of menu items.
///
/// The drawer opening hamburger icon is controlled in appBar.
class NectarDrawer extends StatelessWidget {
  const NectarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle profileTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 20,
        fontWeight: FontWeight.w600);
    final TextStyle profileSubTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
    final TextStyle menuTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          final user = snapshot.data;

          List<Widget> drawerMenu = <Widget>[CircularProgressIndicator()];
          if (user == null) {
            drawerMenu = [
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nectar',
                          style: profileTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Virtual Cards Collection',
                          style: profileSubTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.login_sharp,
                  size: 36,
                ),
                title: Text(
                  'Log in',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const LoginScreen(), replace: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.mail_sharp,
                  size: 36,
                ),
                title: Text(
                  'Sign up',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const RegisterScreen(), replace: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline_sharp,
                  size: 36,
                ),
                title: Text(
                  'About Nectar',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const HelpHomeScreen());
                },
              ),
            ];
          } else {
            drawerMenu = [
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          (user.displayName == null
                              ? user.email!
                              : user.displayName!),
                          style: profileTextStyle,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.collections_sharp,
                  size: 36,
                ),
                title: Text(
                  'Cards Collection',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const CardsCollectionScreen(), replace: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.credit_card_sharp,
                  size: 36,
                ),
                title: Text(
                  'My Cards',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const MyCardsScreen(), replace: true);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add_to_photos_sharp,
                  size: 36,
                ),
                title: Text(
                  'Add A New Card',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const AddSingleCardScreen());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline_sharp,
                  size: 36,
                ),
                title: Text(
                  'Help',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const HelpHomeScreen());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_sharp,
                  size: 36,
                ),
                title: Text(
                  'Log Out',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const LogoutScreen(), clearStack: true);
                },
              ),
            ];
          }

          return Drawer(
            child: SafeArea(
              child: Column(spacing: 18, children: drawerMenu),
            ),
          );
        });
  }
}

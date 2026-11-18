import 'package:material_ui/material_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/icons/nectar_large_icon.dart';
import 'package:nectar_app/components/layout/nectar_divider.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
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
                          height: 10,
                        ),
                        Row(spacing: 10, children: [
                          NectarLargeIcon(
                            Icons.hive_sharp,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          NectarLargeText(
                            'Nectar',
                            fontSize: 22,
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Virtual Cards Collection',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
              ),
              NectarDivider(),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.login_sharp,
                ),
                title: Text(
                  'Log in',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const LoginScreen(), replace: true);
                },
              ),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.mail_sharp,
                ),
                title: Text(
                  'Sign up',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const RegisterScreen(),
                      replace: true);
                },
              ),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.help_outline_sharp,
                ),
                title: Text(
                  'About',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const HelpHomeScreen());
                },
              ),
              NectarDivider(),
            ];
          } else {
            drawerMenu = [
              ListTile(
                leading: NectarLargeIcon(
                  Icons.account_box_sharp,
                ),
                title: NectarLargeText(
                  fontSize: 22,
                  (user.displayName == null
                      ? user.email!
                      : user.displayName!
                          .substring(0, user.displayName!.indexOf(' '))),
                ),
                // onTap: () {
                //   Navigator.of(context).pop();
                //   nectarNavigate(context, const CardsCollectionScreen(),
                //       replace: true);
                // },
              ),
              NectarDivider(),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.collections_sharp,
                ),
                title: Text(
                  'Collection',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const CardsCollectionScreen(),
                      replace: true);
                },
              ),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.credit_card_sharp,
                ),
                title: Text(
                  'My Own Cards',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const MyCardsScreen(), replace: true);
                },
              ),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.add_to_photos_sharp,
                ),
                title: Text(
                  'Add Card',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const AddSingleCardScreen());
                },
              ),
              NectarDivider(),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.help_outline_sharp,
                ),
                title: Text(
                  'Help',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const HelpHomeScreen());
                },
              ),
              ListTile(
                leading: NectarLargeIcon(
                  Icons.logout_sharp,
                ),
                title: Text(
                  'Log Out',
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  nectarNavigate(context, const LogoutScreen(),
                      clearStack: true);
                },
              ),
            ];
          }

          return Drawer(
            child: SafeArea(
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(spacing: 18, children: drawerMenu)),
            ),
          );
        });
  }
}

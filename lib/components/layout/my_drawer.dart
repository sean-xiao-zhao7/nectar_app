import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/auth/logout_screen.dart';
import 'package:nectar_app/screens/auth/register_screen.dart';
import 'package:nectar_app/screens/cards/cards_home_screen.dart';
import 'package:nectar_app/screens/home_screen.dart';

/// The main drawer
///
/// Has a profile section at top.
/// Then a column of menu items.
///
/// The drawer opening hamburger icon is controlled in appBar.
class MyDrawer extends StatelessWidget {
  final String? userTitle;
  final String? userSubTitle;

  const MyDrawer({super.key, this.userTitle, this.userSubTitle});

  @override
  Widget build(BuildContext context) {
    final TextStyle profileTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 22,
        fontWeight: FontWeight.w600);
    final TextStyle profileSubTextStyle =
        TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
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
                  padding: EdgeInsets.only(left: 25, right: 25),
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
                          'Virtual Business Card',
                          style: profileSubTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 34,
                ),
                title: Text(
                  'Home',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.login,
                  size: 34,
                ),
                title: Text(
                  'Log in',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle_sharp,
                  size: 32,
                ),
                title: Text(
                  'Sign up',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
              ),
            ];
          } else {
            drawerMenu = [
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.only(left: 25, right: 25),
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
                          userTitle == null ? user.email! : userTitle!,
                          style: profileTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userSubTitle == null ? 'Regular user' : userSubTitle!,
                          style: profileSubTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 34,
                ),
                title: Text(
                  'Home',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.credit_card,
                  size: 34,
                ),
                title: Text(
                  'Cards',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const CardsHomeScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 34,
                ),
                title: Text(
                  'Log out',
                  style: menuTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LogoutScreen(),
                    ),
                  );
                },
              ),
            ];
          }

          return Drawer(
            child: SafeArea(
              child: Column(spacing: 10, children: drawerMenu),
            ),
          );
        });
  }
}

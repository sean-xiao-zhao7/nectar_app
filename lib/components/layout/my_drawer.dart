import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String userTitle;
  final String userSubTitle;

  const MyDrawer({super.key, this.userTitle = '', this.userSubTitle = ''});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Container(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userTitle, //'Jean Cyan',
                        ),
                        Text(
                          userSubTitle, //'jean.cyan@nectar.io',
                        ),
                      ]),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}

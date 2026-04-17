import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String userTitle;
  final String userSubTitle;

  const MyDrawer({super.key, this.userTitle = '', this.userSubTitle = ''});

  @override
  Widget build(BuildContext context) {
    final TextStyle profileTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 18,
        fontWeight: FontWeight.w500);
    final TextStyle menuTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

    return Drawer(
      child: SafeArea(
        child: Column(
          spacing: 5,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Container(
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userTitle,
                          style: profileTextStyle,
                        ),
                        Text(
                          userSubTitle,
                          style: profileTextStyle,
                        ),
                      ]),
                ),
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
            ),
            ListTile(
              leading: Icon(
                Icons.account_box,
                size: 32,
              ),
              title: Text(
                'Sign up',
                style: menuTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

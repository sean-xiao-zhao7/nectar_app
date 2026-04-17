import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String userTitle;
  final String userSubTitle;

  const MyDrawer({super.key, this.userTitle = '', this.userSubTitle = ''});

  @override
  Widget build(BuildContext context) {
    final TextStyle profileTextStyle = TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 24,
        fontWeight: FontWeight.w500);
    final TextStyle profileSubTextStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    final TextStyle menuTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

    return Drawer(
      child: SafeArea(
        child: Column(
          spacing: 5,
          children: <Widget>[
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
                        userTitle,
                        style: profileTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userSubTitle,
                        style: profileSubTextStyle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 10,
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

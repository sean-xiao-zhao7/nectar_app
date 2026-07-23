import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? appBarLead;
  final List<Widget>? appBarActions;

  const MyAppBar(
      {super.key, this.title = 'Nectar', this.appBarActions, this.appBarLead});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => appBarLead != null
            ? appBarLead!
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
      ),
      actions: appBarActions,
      title: Text(
        title,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

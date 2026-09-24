import 'package:flutter/material.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';

class NectarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? appBarLead;
  final PreferredSizeWidget? appBarBottom;
  final List<Widget>? appBarActions;

  const NectarAppBar(
      {super.key,
      this.title = 'Nectar',
      this.appBarActions,
      this.appBarBottom,
      this.appBarLead});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) => appBarLead != null
            ? appBarLead!
            : IconButton(
                icon: const Icon(Icons.menu_sharp),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
      ),
      actions: appBarActions,
      title: NectarLargeText(
        color: Theme.of(context).colorScheme.secondary,
        title,
      ),
      bottom: appBarBottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

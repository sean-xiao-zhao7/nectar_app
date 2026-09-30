import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/helpers/auth_helper.dart';

/// Log in an existing user
class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  void _doLogout() async {
    await logoutHelper();
  }

  @override
  Widget build(BuildContext context) {
    _doLogout();
    return NectarScaffoldContainer(
        title: 'Log out',
        child: NectarLargeText('You have logged out of Nectar.'));
  }
}

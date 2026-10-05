import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/util/nectar_loading_indicator.dart';
import 'package:nectar_app/helpers/auth_helper.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/screens/help/help_home_screen.dart';

/// Screen displaying logout confirmation after signing out the user
class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  bool _isLoading = true;
  String _message = 'Logging out...';

  @override
  void initState() {
    super.initState();
    _doLogout();
  }

  Future<void> _doLogout() async {
    final error = await logoutHelper();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      if (error.isEmpty) {
        _message = 'You have logged out of Nectar.';
      } else {
        _message = error;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NectarScaffoldContainer(
      title: 'Log out',
      appBarActions: [
        IconButton(
          onPressed: () => nectarNavigate(context, const HelpHomeScreen()),
          icon: const Icon(
            Icons.help_outline_sharp,
            size: 30,
          ),
        )
      ],
      child: _isLoading
          ? const Nectarloadingindicator()
          : NectarLargeText(_message),
    );
  }
}

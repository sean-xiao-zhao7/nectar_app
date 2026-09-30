import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';

class HelpHomeScreen extends StatelessWidget {
  const HelpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NectarScaffoldContainer(
        title: 'Nectar Help', child: Text('Help content.'));
  }
}

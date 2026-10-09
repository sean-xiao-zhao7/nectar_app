import 'package:flutter/material.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';

/// Bottom footer for Nectar screens
///
/// Displays the copyright text centered with vertical padding.
class NectarFooter extends StatelessWidget {
  const NectarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: NectarRegularText(
            '\u00a9 2026 Nectar Inc.',
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
          ),
        ));
  }
}

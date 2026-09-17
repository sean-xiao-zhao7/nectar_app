import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// An icon and a text side by side
class NectarIconRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool iconFirst;
  final FaIconData? faIconData;

  const NectarIconRow(
      {super.key,
      this.icon = Icons.abc,
      this.iconFirst = true,
      this.faIconData,
      required this.label});

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = faIconData == null
        ? Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
            size: 24,
          )
        : FaIcon(
            faIconData,
            size: 24,
            color: Theme.of(context).colorScheme.secondary,
          );

    return Row(
      spacing: 5,
      children: [
        if (iconFirst) iconWidget,
        Text(label),
        if (!iconFirst) iconWidget
      ],
    );
  }
}

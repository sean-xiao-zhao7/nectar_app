import 'package:flutter/material.dart';

/// An icon and a text side by side
class NectarIconRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool iconFirst;

  const NectarIconRow(
      {super.key,
      this.icon = Icons.abc,
      this.iconFirst = true,
      required this.label});

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Icon(
      icon,
      color: Theme.of(context).colorScheme.secondary,
      size: 24,
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

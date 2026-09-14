import 'package:flutter/material.dart';

class NectarDivider extends StatelessWidget {
  const NectarDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

import 'package:flutter/material.dart';

class NectarDivider extends StatelessWidget {
  final double? height;
  const NectarDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      height: height,
    );
  }
}

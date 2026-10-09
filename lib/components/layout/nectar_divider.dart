import 'package:flutter/material.dart';

/// Horizontal divider for Nectar
///
/// Draws a [Divider] using the theme's primary color ([ColorScheme.primary])
/// with a configurable height defaulting to 10px.
class NectarDivider extends StatelessWidget {
  final double? height;
  const NectarDivider({super.key, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      height: height,
    );
  }
}

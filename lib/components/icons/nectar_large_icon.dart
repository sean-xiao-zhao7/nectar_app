import 'package:flutter/material.dart';

/// Large icon for Nectar
///
/// Preconfigured [Icon] with default size of 36
/// and default color of [ColorScheme.primary].
class NectarLargeIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const NectarLargeIcon(
    this.icon, {
    super.key,
    this.size = 36,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? Theme.of(context).colorScheme.secondary,
    );
  }
}

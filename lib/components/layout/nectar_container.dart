import 'package:flutter/material.dart';

/// Default container box for Nectar
///
/// Wraps [child] in a styled [Container] with card-like drop shadow,
/// theme-based background ([ColorScheme.onPrimary]), and default padding of 20px.
class NectarContainer extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const NectarContainer(
      {super.key,
      required this.child,
      this.alignment,
      this.margin,
      this.padding = const EdgeInsets.all(20)});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ]),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

/// Full-height expanded container for Nectar screens
///
/// Wraps [child] in an [Expanded] container styled with rounded corners (10px),
/// theme background ([ColorScheme.onPrimary]), and a subtle drop shadow.
class NectarExpandedContainer extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const NectarExpandedContainer(
      {super.key,
      required this.child,
      this.alignment,
      this.margin,
      this.padding = const EdgeInsets.all(20)});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            alignment: alignment,
            padding: padding,
            margin: margin,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ]),
            child: child,
          ),
        ),
      ],
    );
  }
}

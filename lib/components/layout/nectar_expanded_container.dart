import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/nectar_column.dart';
import 'package:nectar_app/components/layout/nectar_container.dart';

/// Full-height and width expanded container for Nectar screens
///
/// A NectarContainer inside a NectarColumn with Expanded.
/// A full-width/height white background.
class NectarExpandedContainer extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final Widget child;

  const NectarExpandedContainer({
    super.key,
    this.crossAxisAlignment,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NectarColumn(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
        children: [Expanded(child: NectarContainer(child: child))]);
  }
}

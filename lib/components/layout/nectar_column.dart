import 'package:flutter/material.dart';

/// Default column layout for Nectar
///
/// Preconfigured [Column] with 20px spacing between children
/// and [CrossAxisAlignment.start] alignment by default.
class NectarColumn extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final List<Widget> children;

  const NectarColumn(
      {super.key, this.crossAxisAlignment, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: 20,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: children);
  }
}

import 'package:flutter/material.dart';

class NectarColumn extends StatelessWidget {
  final List<Widget> children;
  const NectarColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children);
  }
}

import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry? alignment;

  const MyContainer({super.key, required this.child, this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
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
    );
  }
}

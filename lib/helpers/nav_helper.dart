import 'package:flutter/material.dart';

/// Centralized navigation helper for Nectar.
///
/// - Default: Standard push navigation.
/// - [replace]: Replaces current screen (prevents back-navigating to forms).
/// - [clearStack]: Clears entire history stack (for Login, Logout, Auth reset).
void nectarNavigate(
  BuildContext context,
  Widget targetScreen, {
  bool replace = false,
  bool clearStack = false,
}) {
  final route = MaterialPageRoute<void>(builder: (_) => targetScreen);

  if (clearStack) {
    Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
  } else if (replace) {
    Navigator.of(context).pushReplacement(route);
  } else {
    Navigator.of(context).push(route);
  }
}

/// Helper to pop the current screen
void nectarPop(BuildContext context) {
  Navigator.of(context).pop();
}


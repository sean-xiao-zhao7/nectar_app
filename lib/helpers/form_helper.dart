import 'package:flutter/material.dart';

InputDecoration fieldDecoration(BuildContext context, String labelText) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelText: labelText,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), gapPadding: 10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  );
}

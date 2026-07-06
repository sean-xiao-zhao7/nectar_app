import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/cards_home_screen.dart';

/// Screen form on-click callback for adding a new card.
Future<void> addNewCardFormHelper(
  BuildContext context,
  GlobalKey<FormState> formKey,
  Map<String, String> fields,
  String successText,
) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  final resultMessage = await _addSingleCard(fields);
  if (!context.mounted) {
    return;
  }

  if (resultMessage.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added a new card.')),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const CardsHomeScreen(),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(resultMessage)),
  );
}

/// Add a single new card
///
///
Future<String> _addSingleCard(Map<String, String> fields) async {
  String resultMessage = '';
  try {
    final newCardRef =
        FirebaseDatabase.instance.ref('cards/${fields['uid']}').push();
    await newCardRef.set(fields);
  } on FirebaseException catch (_) {
    resultMessage = 'Server error. Please try again later.';
  }
  return resultMessage;
}

/// Get current user's all cards from Firebase Realtime Database
///
/// userId is the firebaseAuth id.
/// Return [] if the user does not have any cards.
Future<List<NectarCard>> fetchUserAllCards(String userId) async {
  try {
    final event = await FirebaseDatabase.instance.ref('cards/$userId').once();
    if (event.snapshot.exists) {
      return event.snapshot.value as List<NectarCard>;
    } else {
      return [];
    }
  } on FirebaseException catch (e) {
    throw Exception(
        'Unable to fetch cards for user $userId from Firebase Realtime Database.\n${e.message}');
  }
}

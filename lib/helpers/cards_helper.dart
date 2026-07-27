import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/my_cards_screen.dart';

/// Screen form on-click callback for adding a new card.
Future<void> addNewCardFormHelper(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Map<String, String> fields,
    String successText,
    {bool fetchOwnedCards = true}) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  final resultMessage =
      await _addSingleCard(fields, fetchOwnedCards: fetchOwnedCards);
  if (!context.mounted) {
    return;
  }

  if (resultMessage.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added a new card.')),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MyCardsScreen(),
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
Future<String> _addSingleCard(Map<String, String> fields,
    {bool fetchOwnedCards = true}) async {
  String resultMessage = '';
  try {
    final newCardRef = FirebaseDatabase.instance
        .ref(
            "${fetchOwnedCards ? 'user_owned_cards/' : 'cards_collection/'}${fields['uid']}")
        .push();
    await newCardRef.set(fields);
  } on FirebaseException catch (_) {
    resultMessage = 'Server error. Please try again later.';
  }
  return resultMessage;
}

/// Screen form on-click callback for editing a new card.
Future<void> editCardFormHelper(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Map<String, String> fields,
    String successText,
    String cardId,
    {bool fetchOwnedCards = true}) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  final resultMessage =
      await _editSingleCard(fields, cardId, fetchOwnedCards: fetchOwnedCards);
  if (!context.mounted) {
    return;
  }

  if (resultMessage.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edited card.')),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const MyCardsScreen(),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(resultMessage)),
  );
}

/// Edit a single card
Future<String> _editSingleCard(Map<String, String> fields, String cardId,
    {bool fetchOwnedCards = true}) async {
  String resultMessage = '';
  try {
    final cardRef = FirebaseDatabase.instance.ref(
        "${fetchOwnedCards ? 'user_owned_cards/' : 'cards_collection/'}${fields['uid']}/$cardId");
    await cardRef.update(fields);
  } on FirebaseException catch (_) {
    resultMessage = 'Server error. Please try again later.';
  }
  return resultMessage;
}

/// Get current user's all cards from Firebase Realtime Database
///
/// userId is the firebaseAuth id.
/// Return [] if the user does not have any cards.
///
/// fetchOwnedCards is true by default, if false,
/// the function fetches card collection of an user instead of cards owned by the user.
Future<List<NectarCard>> fetchUserAllCards(String userId,
    {bool fetchOwnedCards = true}) async {
  try {
    final event = await FirebaseDatabase.instance
        .ref((fetchOwnedCards ? 'user_owned_cards/' : 'cards_collection/') +
            userId)
        .once();
    if (event.snapshot.exists) {
      List<NectarCard> cardList = [];
      Map<dynamic, dynamic> firebaseDataMap =
          event.snapshot.value! as Map<dynamic, dynamic>;
      for (String key in firebaseDataMap.keys) {
        NectarCard card = NectarCard(
            ownerUserId: userId,
            cardId: key,
            firstName: firebaseDataMap[key]['firstName'],
            lastName: firebaseDataMap[key]['lastName'],
            email: firebaseDataMap[key]['email'],
            address: firebaseDataMap[key]['address'],
            company: firebaseDataMap[key]['company'],
            city: firebaseDataMap[key]['city'],
            country: firebaseDataMap[key]['country'],
            job: firebaseDataMap[key]['job'],
            phone: firebaseDataMap[key]['phone'],
            website: firebaseDataMap[key]['website'],
            postal: firebaseDataMap[key]['postal']);
        cardList.add(card);
      }
      return cardList;
    } else {
      return [];
    }
  } on FirebaseException catch (e) {
    throw Exception(
        'Unable to fetch cards for user $userId from Firebase Realtime Database.\n${e.message}');
  }
}

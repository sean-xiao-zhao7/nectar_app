import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/cards_collection_screen.dart';
import 'package:nectar_app/screens/cards/my_cards_screen.dart';

/// Handles adding a new card from the "Manually add" tab using a form.
Future<void> addNewCardFormHelper(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Map<String, dynamic> fields,
    String successText,
    {bool isOwnCard = true}) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  final resultMessage =
      await addSingleCardDB(fields, isOwnCard: isOwnCard);
  if (!context.mounted) {
    return;
  }

  if (resultMessage.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added a new card.')),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => isOwnCard
            ? const MyCardsScreen()
            : const CardsCollectionScreen(),
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
Future<String> addSingleCardDB(Map<String, dynamic> fields,
    {bool isOwnCard = true}) async {
  String resultMessage = '';
  try {
    final newCardRef = FirebaseDatabase.instance
        .ref(
            "${isOwnCard ? 'user_owned_cards/' : 'cards_collection/'}${fields['uid']}")
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
    Map<String, dynamic> fields,
    String successText,
    String cardId,
    {bool isOwnCard = true}) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  final resultMessage =
      await _editSingleCard(fields, cardId, isOwnCard: isOwnCard);
  if (!context.mounted) {
    return;
  }

  if (resultMessage.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edited card.')),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => isOwnCard
            ? const MyCardsScreen()
            : const CardsCollectionScreen(),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(resultMessage)),
  );
}

/// Edit a single card
Future<String> _editSingleCard(Map<String, dynamic> fields, String cardId,
    {bool isOwnCard = true}) async {
  String resultMessage = '';
  try {
    final cardRef = FirebaseDatabase.instance.ref(
        "${isOwnCard ? 'user_owned_cards/' : 'cards_collection/'}${fields['uid']}/$cardId");
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
/// isOwnCard is true by default, if false,
/// the function fetches card collection of an user instead of cards owned by the user.
Future<List<NectarCard>> fetchUserAllCards(String userId,
    {bool isOwnCard = true}) async {
  try {
    final event = await FirebaseDatabase.instance
        .ref((isOwnCard ? 'user_owned_cards/' : 'cards_collection/') +
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
          mainName: firebaseDataMap[key]['mainName'],
          shortDescription: firebaseDataMap[key]['shortDescription'],
          personalInfo: firebaseDataMap[key]['personalInfo'],
          companyInfo: firebaseDataMap[key]['companyInfo'],
          addressInfo: firebaseDataMap[key]['addressInfo'],
          socialMedia: firebaseDataMap[key]['socialMedia'],
        );
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

/// Delete a single card
Future<void> deleteSingleCard(String cardId, String uid,
    {bool isOwnCard = false}) async {
  try {
    final cardRef = FirebaseDatabase.instance.ref(
        '${isOwnCard ? 'user_owned_cards/' : 'cards_collection/'}$uid/$cardId');
    await cardRef.remove();
  } on FirebaseException catch (_) {
    rethrow;
  }
}

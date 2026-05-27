import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:nectar_app/models/nectar_card.dart';

/// Get current user's all cards from Firebase Realtime Database
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

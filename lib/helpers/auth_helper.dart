import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nectar_app/models/user.dart';

/// Sign up using email and password firebase call
///
/// Returns an empty string if no error, or the actual English error message.
Future<String> signUpHelper(String emailVal, String passwordVal,
    String firstName, String lastName) async {
  String resultMessage = '';
  try {
    final userCreds =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailVal,
      password: passwordVal,
    );
    await _addUserDB(emailVal, firstName, lastName, userCreds.user!.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      resultMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      resultMessage = 'The account already exists for that email.';
    }
  }

  return resultMessage;
}

/// Call Firebase to add new user
Future<String> _addUserDB(
    String email, String firstName, String lastName, String uid) async {
  String result = '';
  try {
    DatabaseReference ref = FirebaseDatabase.instance.ref('users').push();
    await ref.set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'uid': uid
    });
  } on FirebaseException catch (_) {
    result = 'Server error. Please try again later.';
  }
  return result;
}

/// Log in using email and password firebase call
/// Returns an empty string if no error, or the actual English error message.
Future<String> loginHelper(String emailVal, String passwordVal) async {
  String resultMessage = '';
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailVal,
      password: passwordVal,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential' || e.code == 'invalid-email') {
      resultMessage = 'Credientials incorrect. Please try again.';
    }
  }

  return resultMessage;
}

/// Log out
Future<String> logoutHelper() async {
  String resultMessage = '';
  try {
    await FirebaseAuth.instance.signOut();
  } on FirebaseAuthException catch (_) {
    resultMessage = 'Server error during log out. Please try again later.';
  }

  return resultMessage;
}

/// Get user info
Future<NectarUser> fetchUserInfo(String firebaseId) async {
  try {
    final event =
        await FirebaseDatabase.instance.ref('users/$firebaseId').once();
    if (event.snapshot.exists) {
      final result = event.snapshot.value as Map;
      final nectarUser = NectarUser(
          firstName: result['firstName'],
          lastName: result['lastName'],
          email: result['email']);
      return nectarUser;
    }
  } on FirebaseException catch (_) {
    // print(e.message);
  }
  throw Error();
}

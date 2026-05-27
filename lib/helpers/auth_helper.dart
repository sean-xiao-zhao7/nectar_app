import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nectar_app/models/nectar_user.dart';

/// Sign up using email and password
///
/// Add user into FirebaseAuth and Firebase Realtime Database.
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

/// Helper function for signUpHelper
///
/// Add user into Firebase Realtime Database.
/// User object in RD is indexed by the same UID from Auth.
Future<String> _addUserDB(
    String email, String firstName, String lastName, String uid) async {
  try {
    DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid');
    await ref.set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    });
    return ref.key!;
  } on FirebaseException catch (e) {
    throw Exception(
        'Unable to add user to realtime database. Please try again later.\nFirebase message: ${e.message}');
  }
}

/// Log in using email and password
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

/// Log in using Google provider.
Future<String> loginHelperGoogle() async {
  String resultMessage = '';
  try {
    final resultGoogle =
        await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
    print(resultGoogle);
    // await _addUserDB(emailVal, firstName, lastName, userCreds.user!.uid);
  } on FirebaseAuthException catch (e) {
    resultMessage = e.message ?? 'Google login failed. Please try again.';
  }

  return resultMessage;
}

/// Get current user info from Firebase Realtime Database
/// firebaseUid is uid field from Firebase Auth.
Future<NectarUser> fetchUserInfo(String firebaseUid) async {
  try {
    final event =
        await FirebaseDatabase.instance.ref('users/$firebaseUid').once();
    if (event.snapshot.exists) {
      final result = event.snapshot.value as Map;
      final nectarUser = NectarUser(
          firstName: result['firstName'],
          lastName: result['lastName'],
          email: result['email']);
      return nectarUser;
    }
  } on FirebaseException catch (e) {
    throw Exception(
        'Unable to fetch user info from Firebase Realtime Database.\n${e.message}');
  }

  throw Exception(
      'No user object found in RD for $firebaseUid.\nPossible desync between RD and Auth in Firebase.');
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

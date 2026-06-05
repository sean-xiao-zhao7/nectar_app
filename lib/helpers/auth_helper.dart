import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';

import 'package:nectar_app/models/nectar_user.dart';
import 'package:nectar_app/screens/home_screen.dart';

/// Sign up using email and password
///
/// Add user into FirebaseAuth and Firebase Realtime Database.
Future<String> signUpHelper(Map<String, String> controllerTexts) async {
  String resultMessage = '';
  try {
    final userCreds =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: controllerTexts['email']!,
      password: controllerTexts['password']!,
    );
    await _addUserDB(controllerTexts['email']!, controllerTexts['firstName']!,
        controllerTexts['lastName']!, userCreds.user!.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      resultMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      resultMessage = 'The account already exists for that email.';
    }
  }

  return resultMessage;
}

/// Log in using email and password
Future<String> loginHelper(Map<String, String> controllerTexts) async {
  String resultMessage = '';
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: controllerTexts['email']!,
      password: controllerTexts['password']!,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential' || e.code == 'invalid-email') {
      resultMessage = 'Credientials incorrect. Please try again.';
    }
  }

  return resultMessage;
}

/// Log in / Sign up using Google provider.
/// https://firebase.google.com/docs/auth/flutter/federated-auth
///
/// If first time login, save name and email into RDB.
Future<String> loginHelperGoogle() async {
  String resultMessage = '';
  try {
    final GoogleSignInAccount googleUser =
        await GoogleSignIn.instance.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final googleCredential =
        GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    final firesbaseResult =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    // print(firesbaseResult);

    if (firesbaseResult.additionalUserInfo!.isNewUser) {
      await _addUserDB(
          firesbaseResult.additionalUserInfo!.profile!['email'],
          firesbaseResult.additionalUserInfo!.profile!['given_name'],
          firesbaseResult.additionalUserInfo!.profile!['family_name'],
          firesbaseResult.user!.uid);
    }
  } on FirebaseAuthException catch (e) {
    resultMessage = e.message ?? 'Server error. Please try again later.';
  } on GoogleSignInException catch (e) {
    if (e.code == GoogleSignInExceptionCode.canceled) {
      resultMessage = e.description!;
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

// UI helpers

/// Call non-federated login helper when form submitted with email/password.
void authFormSubmitHelper(
  BuildContext context,
  GlobalKey<FormState> formKey,
  Future<String> Function(Map<String, String>) helperFunction,
  Map<String, String> controllerTexts,
  String successText,
) async {
  if (!formKey.currentState!.validate()) {
    return;
  }

  String resultMessage = await helperFunction(controllerTexts);

  if (resultMessage.isEmpty) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: MyRegularText(successText)),
      );

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  } else {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultMessage)),
      );
    }
  }
}

/// Call Google login helper when form submitted with Google option.
void authFormSubmitGoogleHelper(BuildContext context) async {
  final resultMessage = await loginHelperGoogle();
  if (!context.mounted) {
    return;
  }

  if (resultMessage.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google login successful.')),
    );

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const HomeScreen(),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(resultMessage)),
  );
}

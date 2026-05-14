import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/home_screen.dart';

// Sign up using email and password firebase call
// Returns an empty string if no error, or the actual English error message.
Future<String> signUpHelper(String emailVal, String passwordVal) async {
  String resultMessage = '';
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailVal,
      password: passwordVal,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      resultMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      resultMessage = 'The account already exists for that email.';
    }
  }

  return resultMessage;
}

// Log in using email and password firebase call
// Returns an empty string if no error, or the actual English error message.
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

Future<String> logoutHelper() async {
  String resultMessage = '';
  try {
    await FirebaseAuth.instance.signOut();
  } on FirebaseAuthException catch (_) {
    resultMessage = 'Server error during log out. Please try again later.';
  }

  return resultMessage;
}

// Check firebase auth status at any time.
// https://firebase.google.com/docs/auth/flutter/manage-users
StreamBuilder<User?> getAuthState() {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
      if (snapshot.hasError) {
        return const Text('Network error during authentication.');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      if (!snapshot.hasData) {
        return const LoginScreen();
      }

      // final user = snapshot.data!;
      return HomeScreen();
    },
  );
}

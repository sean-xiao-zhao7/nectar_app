import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// sign up using password firebase call
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

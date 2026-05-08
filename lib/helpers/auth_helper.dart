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

// log in using password firebase call
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

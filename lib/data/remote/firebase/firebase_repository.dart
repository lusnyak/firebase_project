import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef MyUser = User;

///TODO: - signinpopup and signout google

class FireBaseRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleAuthProvider = GoogleAuthProvider();
  final googleSignIn = GoogleSignIn();

  bool checkCurrentUser() => _auth.currentUser != null;

  MyUser? get currentUser => _auth.currentUser;

  Future<void> logout() async {
    _auth.signOut();
    googleSignIn.signOut();
  }

  Future<void> signInViaGoogle() async {
    await googleSignIn.signIn().then((value) async {
      debugPrint(value.toString());
      var authData = await value?.authentication;
      debugPrint(authData?.accessToken);
      debugPrint(authData?.idToken);

      await _auth.signInWithCredential(OAuthCredential(
          providerId: "google.com",
          signInMethod: "google.com",
          accessToken: authData?.accessToken,
          idToken: authData?.idToken));

    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> signInGoogleViaFirebase() async {
    await _auth.signInWithProvider(googleAuthProvider).then((value) {
      debugPrint(value.credential?.asMap().toString());
      debugPrint(value.user?.email);
      debugPrint(value.user?.displayName);
      debugPrint(value.user?.phoneNumber);
      debugPrint(value.user?.photoURL);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<bool?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    debugPrint(email);
    debugPrint(password);
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredentials.user != null;
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "email-already-in-use") {
        throw (MyException(
            "The email address already registered")); // The email address is already in use by another account
      }

      if (ex.code == "invalid-email") {
        throw (MyException("The email format is wrong"));
      }

      if (ex.code == "weak-password") {
        throw (MyException("Password should be at least 6 characters"));
      }

      debugPrint(ex.code);
      throw (MyException(ex.message ?? "Something went wrong"));
    }
  }

  Future<bool?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final signInCredentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return signInCredentials.user != null;
    } on FirebaseAuthException catch (ex) {
      debugPrint(ex.code);
      if (ex.code == "invalid-credential") {
        throw (MyException("Your email or password is wrong"));
      }
      throw (MyException(ex.message ?? "Something went wrong"));
    }
  }
}

class MyException implements Exception {
  final String message;

  MyException(this.message);
}

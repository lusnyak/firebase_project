import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

typedef MyUser = User;

class FireBaseRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool checkCurrentUser() => _auth.currentUser != null;

  MyUser? get currentUser => _auth.currentUser;

  Future<void> logout() async => _auth.signOut();

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
      if(ex.code == "email-already-in-use") {
        throw(MyException("The email address already registered")); // The email address is already in use by another account
      }

      if(ex.code == "invalid-email") {
        throw(MyException("The email format is wrong"));
      }

      if(ex.code == "weak-password") {
        throw(MyException("Password should be at least 6 characters"));
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
      if(ex.code == "invalid-credential") {
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
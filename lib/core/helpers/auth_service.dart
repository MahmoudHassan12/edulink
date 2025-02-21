import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with email & password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log("${userCredential.user}");

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("Sign-in Error: ${e.message}");
      return null;
    }
  }

  /// Sign up with email & password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("${userCredential.user}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log("Sign-up Error: ${e.message}");
      return null;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;
}

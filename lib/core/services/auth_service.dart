import 'dart:developer';
import 'package:edu_link/core/helpers/navigations.dart' show signinNavigation;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  const AuthService();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with Email & Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      log('Signed in: ${userCredential.user}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Sign-in Error: ${e.message}');
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      log('Password reset email sent to $email');
    } on FirebaseAuthException catch (e) {
      log('Password reset error: ${e.message}');
    }
  }

  /// Sign up with Email & Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      log('Signed up: ${userCredential.user}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Sign-up Error: ${e.message}');
      return null;
    }
  }

  /// Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      log('Attempting Google Sign-In...');

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log('Google Sign-In canceled by user.');
        throw Exception('Google Sign-In canceled by user.');
      }

      log('Google User Selected: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      log('Google Access Token: ${googleAuth.accessToken}');
      log('Google ID Token: ${googleAuth.idToken}');

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      log('Google Sign-In successful: ${userCredential.user?.email}');

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Google Sign-In Error: ${e.code} - ${e.message}');
      return null;
    } on Exception catch (e) {
      log('Unexpected Error during Google Sign-In: $e');
      return null;
    }
  }

  /// Facebook Sign-In
  Future<User?> signInWithFacebook() async {
    try {
      log('Attempting Facebook Sign-In...');
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        log('Facebook Access Token: ${accessToken.tokenString}');
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        log('Facebook Signed in successfully: ${userCredential.user?.email}');
        return userCredential.user;
      } else {
        log('Facebook Sign-in failed: ${result.message}');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      log('Facebook Sign-in Error: ${e.code}, Message: ${e.message}');
      return null;
    } on Exception catch (e) {
      log('Unexpected Facebook Sign-in Error: $e');
      return null;
    }
  }

  /// Sign out user
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await GoogleSignIn().isSignedIn().then(
      (signedIn) => signedIn ? GoogleSignIn().signOut() : Future.value(),
    );
    await FacebookAuth.instance.logOut();
    if (context.mounted) {
      signinNavigation(context);
    }
  }

  bool isSignedIn() => currentUser != null;

  /// Get current user
  User? get currentUser => _auth.currentUser;
}

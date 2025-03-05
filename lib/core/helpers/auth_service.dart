import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with Email & Password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Signed in: ${userCredential.user}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Sign-in Error: ${e.message}');
      return null;
    }
  }

  /// Sign up with Email & Password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log('Google Sign-In canceled by user.');
        return null;
      }

      log('Google User Selected: ${googleUser.email}');

      final googleAuth = await googleUser.authentication;
      log('Google Access Token: ${googleAuth.accessToken}');
      log('Google ID Token: ${googleAuth.idToken}');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      log('Google Sign-In successful: ${userCredential.user?.email}');

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      log('Google Sign-In Error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected Error during Google Sign-In: $e');
      return null;
    }
  }

  /// Facebook Sign-In
  Future<User?> signInWithFacebook() async {
    try {
      log('Attempting Facebook Sign-In...');
      final result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!;
        log('Facebook Access Token: ${accessToken.tokenString}');
        final credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );
        final userCredential = await _auth.signInWithCredential(credential);

        log('Facebook Signed in successfully: ${userCredential.user?.email}');
        return userCredential.user;
      } else {
        log('Facebook Sign-in failed: ${result.message}');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      log('Facebook Sign-in Error: ${e.code}, Message: ${e.message}');
      return null;
    } catch (e) {
      log('Unexpected Facebook Sign-in Error: $e');
      return null;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    await _auth.signOut();
    //await GoogleSignIn().signOut();
    //await FacebookAuth.instance.logOut();
    log('User signed out');
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  late User? _user;
  late StreamSubscription<auth.User?> _authStateChangesSubscription;

  AuthProvider() {
    _user =
        _auth.currentUser != null ? _userFromFirebase(_auth.currentUser) : null;
    _authStateChangesSubscription = _auth.authStateChanges().listen((event) {
      _user = _userFromFirebase(event);
      notifyListeners();
    });
  }

  User? get user => _user;

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    super.dispose();
  }

  Future<void> changePassword() async {
    final email = _user!.email!;
    await _auth.sendPasswordResetEmail(email: email);
  }

  void resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    final userName = user.displayName?.split(' ').join("_");
    return User(
        email: user.email,
        uid: user.uid,
        fullName: user.displayName,
        userName: userName);
  }

  // Login method
  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final firebaseUser = _userFromFirebase(result.user);
    // _user = firebaseUser;
    return firebaseUser;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final auth.AuthCredential credential =
            auth.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final auth.UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return _userFromFirebase(userCredential.user);
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Signup method
  Future<User?> signup(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = _userFromFirebase(result.user);
      // _user = firebaseUser;
      return firebaseUser;
    } catch (error) {
      _user = null;
    }
    return null;
  }

  // // Logout method
  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
  }
}

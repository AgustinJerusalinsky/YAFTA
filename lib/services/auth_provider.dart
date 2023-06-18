import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  late User? _user;
  late StreamSubscription<auth.User?> _authStateChangesSubscription;

  AuthProvider() {
    _user =
        _auth.currentUser != null ? _userFromFirebase(_auth.currentUser) : null;
    _authStateChangesSubscription = _auth.authStateChanges().listen((event) {
      print(event);
      _user = _userFromFirebase(event);
      notifyListeners();
    });
  }

  get user => _user;

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    super.dispose();
  }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(email: user.email, uid: user.uid);
  }

  // Login method
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = _userFromFirebase(result.user);
      // _user = firebaseUser;
      return firebaseUser;
    } catch (error) {
      // Handle authentication errors here
      _user = null;
    }
    return null;
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:yafta/utils/remote_config.dart';

import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  late User? _user;
  late StreamSubscription<auth.User?> _authStateChangesSubscription;

  late AppTheme _theme;

  AuthProvider() {
    _user =
        _auth.currentUser != null ? _userFromFirebase(_auth.currentUser) : null;
    _authStateChangesSubscription = _auth.authStateChanges().listen((event) {
      _user = _userFromFirebase(event);
      notifyListeners();
    });
    _theme = RemoteConfigHandler.getTheme();
    notifyListeners();
  }

  User? get user => _user;

  AppTheme get theme => _theme;

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

  void toggleDarkTheme() {
    _theme = _theme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    notifyListeners();
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

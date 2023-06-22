import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yafta/utils/remote_config.dart';

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

  late AppTheme _theme;

  AuthProvider() {
    _user =
        _auth.currentUser != null ? _userFromFirebase(_auth.currentUser) : null;
    _authStateChangesSubscription = _auth.authStateChanges().listen((event) {
      _user = _userFromFirebase(event);
      notifyListeners();
    });
    _theme = user?.theme ?? AppTheme.light;
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

  Future<void> resetPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  void toggleDarkTheme() {
    _theme = _theme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    notifyListeners();
  }

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    //split the photoURL to get username, theme
    final parts = user.photoURL?.split('THEME#');

    return User(
        email: user.email,
        uid: user.uid,
        fullName: user.displayName,
        userName: parts?[0],
        theme: _getAppTheme(parts));
  }

  AppTheme _getAppTheme(List<String>? parsedURL) {
    if (parsedURL == null || parsedURL.length < 2) {
      return AppTheme.light;
    }
    final theme = parsedURL[1];

    if (theme == 'light') {
      return AppTheme.light;
    } else {
      return AppTheme.dark;
    }
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

  Future<void> toggleTheme(AppTheme theme) async {
    _theme = theme;
    notifyListeners();
    final photoURL = '${_user?.userName}THEME#${theme.name}';
    await _auth.currentUser?.updatePhotoURL(photoURL);
    final user = _userFromFirebase(_auth.currentUser);
    _user = user;
    notifyListeners();
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

        final firebaseUser = userCredential.user;
        final username = googleSignInAccount.email.split('@')[0];
        await firebaseUser?.updateDisplayName(googleSignInAccount.displayName);
        await firebaseUser?.updatePhotoURL('${username}THEME#light');

        return _userFromFirebase(_auth.currentUser);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  // Signup method
  Future<User?> signup(
      String email, String password, String fullname, String username) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = result.user;

      await firebaseUser?.updateDisplayName(fullname);
      await firebaseUser?.updatePhotoURL('${username}THEME#light');
      final user = _userFromFirebase(_auth.currentUser);
      _user = user;
      notifyListeners();
      // _user = firebaseUser;
      return user;
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

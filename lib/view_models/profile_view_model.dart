import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String _userName = "Guest";
  String _userEmail = "Not signed in";
  String _photoURL = "";
  bool _isSignedIn = false;

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get photoURL => _photoURL;
  bool get isSignedIn => _isSignedIn;

  Future<void> checkAuthStatus() async {
    final user = await _authService.getCurrentUser();
    _isSignedIn = user != null;
    if (_isSignedIn) {
      _userName = user?.displayName ?? "User";
      _userEmail = user?.email ?? "No email available";
      _photoURL = user?.photoURL ?? "";
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _isSignedIn = false;
    _userName = "Guest";
    _userEmail = "Not signed in";
    _photoURL = "";
    notifyListeners();
  }

  Future<void> signIn() async {
    final user = await _authService.signInWithGoogle();
    _isSignedIn = user != null;
    if (_isSignedIn) {
      _userName = user?.displayName ?? "User";
      _userEmail = user?.email ?? "No email available";
      _photoURL = user?.photoURL ?? "";
    }
    notifyListeners();
  }
}

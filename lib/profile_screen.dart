import 'package:flutter/material.dart';
import 'auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

  String _userName = "Guest";
  String _userEmail = "Not signed in";
  bool _isSignedIn = false; // New flag to track sign-in status

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _isSignedIn = user != null;
      if (_isSignedIn) {
        _userName = user?.displayName ?? "User";
        _userEmail = user?.email ?? "No email available";
      }
    });
  }

  Future<void> _signOut() async {
    await _authService.signOut();
    setState(() {
      _isSignedIn = false;
      _userName = "Guest";
      _userEmail = "Not signed in";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signed out successfully!')),
    );
  }

  Future<void> _signIn() async {
    final user = await _authService.signInWithGoogle();
    setState(() {
      _isSignedIn = user != null;
      if (_isSignedIn) {
        _userName = user?.displayName ?? "User";
        _userEmail = user?.email ?? "No email available";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(  // Center widget ensures the content is in the center of the screen
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center column items vertically
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 20),
              Text(
                _userName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                _userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isSignedIn ? _signOut : _signIn,
                style: ElevatedButton.styleFrom(
                  foregroundColor: _isSignedIn ? Colors.red : Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  _isSignedIn ? 'Sign Out' : 'Sign In',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

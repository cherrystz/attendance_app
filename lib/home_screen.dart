import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart'; // Import your auth_service here

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService(); // Instance of your auth_service

  Future<void> _checkIn() async {
    final user = await _authService.getCurrentUser(); // Using auth_service to get current user
    if (user != null) {
      await _firestore.collection('attendance').doc(user.uid).collection('records').add({
        'checkIn': DateTime.now(),
        'checkOut': null,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checked in successfully!')),
      );
    }
  }

  Future<void> _checkOut() async {
  final user = await _authService.getCurrentUser();
  if (user != null) {
    // Get the latest active check-in record
    final snapshot = await _firestore
        .collection('attendance')
        .doc(user.uid)
        .collection('records')
        .where('checkOut', isNull: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final record = snapshot.docs.first;
      await record.reference.update({
        'checkOut': DateTime.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Checked out successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No active check-in found.')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _checkIn,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text('Check In', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkOut,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text('Check Out', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../models/attendance_model.dart';

class HomeViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkIn(BuildContext context) async {
    _setLoading(true);

    final user = await _authService.getCurrentUser();
    if (user != null) {
      final snapshot = await _firestore
          .collection('attendance')
          .doc(user.uid)
          .collection('records')
          .where('checkOut', isNull: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        final attendanceRecord = AttendanceModel(checkIn: DateTime.now(), checkOut: null);
        await _firestore.collection('attendance').doc(user.uid).collection('records').add({
          'checkIn': attendanceRecord.checkIn,
          'checkOut': attendanceRecord.checkOut,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Checked in successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have already checked in.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You should sign-in first.')),
      );
    }

    _setLoading(false);
  }

  Future<void> checkOut(BuildContext context) async {
    _setLoading(true);

    final user = await _authService.getCurrentUser();
    if (user != null) {
      final snapshot = await _firestore
          .collection('attendance')
          .doc(user.uid)
          .collection('records')
          .where('checkOut', isNull: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final record = snapshot.docs.first;

        final attendanceRecord = AttendanceModel(
          checkIn: record['checkIn'].toDate(),
          checkOut: DateTime.now(),
        );

        await record.reference.update({
          'checkOut': attendanceRecord.checkOut,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Checked out successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No active check-in found.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You should sign-in first.')),
      );
    }

    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

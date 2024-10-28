import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attendance_model.dart';
import '../services/auth_service.dart';

class CalendarViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  List<AttendanceModel> _attendanceRecords = [];
  bool _isLoading = false;
  
  void _setLoading(bool loading) { // Still private
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchAttendance(DateTime selectedDay) async {
    _setLoading(true);
    final user = await _authService.getCurrentUser();
    if (user != null) {
      final startOfDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final snapshot = await _firestore
          .collection('attendance')
          .doc(user.uid)
          .collection('records')
          .where('checkIn', isGreaterThanOrEqualTo: startOfDay)
          .where('checkIn', isLessThan: endOfDay)
          .get();

      _attendanceRecords = snapshot.docs
          .map((doc) => AttendanceModel.fromFirestore(doc.data()))
          .toList();
    }
    _setLoading(false);
  }

  // Accessor
  List<AttendanceModel> get attendanceRecords => _attendanceRecords; 
  
  FirebaseFirestore get firestore => _firestore;
  AuthService get authService => _authService;
  bool get isLoading => _isLoading;
  void setLoading(bool loading) {
    _setLoading(loading);
  }
}


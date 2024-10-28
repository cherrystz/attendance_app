import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  final DateTime checkIn;
  final DateTime? checkOut;

  AttendanceModel({required this.checkIn, this.checkOut});

  factory AttendanceModel.fromFirestore(Map<String, dynamic> data) {
    return AttendanceModel(
      checkIn: (data['checkIn'] as Timestamp).toDate(),
      checkOut: data['checkOut'] != null ? (data['checkOut'] as Timestamp).toDate() : null,
    );
  }
}

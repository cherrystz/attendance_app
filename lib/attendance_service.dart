import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check-in
  Future<void> checkIn() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('attendance').doc(user.uid).collection('records').add({
        'checkIn': DateTime.now(),
        'checkOut': null,
      });
    }
  }

  // Check-out
  Future<void> checkOut(DocumentReference record) async {
    await record.update({'checkOut': DateTime.now()});
  }
}

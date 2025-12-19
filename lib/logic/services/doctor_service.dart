import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor.dart';

class DoctorService {
  FirebaseFirestore get _db => FirebaseFirestore.instance;


  Stream<List<Doctor>> getDoctors() {
    return _db.collection('doctors')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Doctor.fromFirestore(doc.data(), doc.id))
        .toList());
  }


  Future<Doctor?> getDoctorById(String id) async {
    final doc = await _db.collection('doctors').doc(id).get();
    if (doc.exists) {
      return Doctor.fromFirestore(doc.data()!, doc.id);
    }
    return null;
  }
}



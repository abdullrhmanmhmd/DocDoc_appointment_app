import 'package:cloud_firestore/cloud_firestore.dart';
import '../logic/models/doctor.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Doctor>> getDoctors() {
    return _db.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Doctor(
          name: data['name'] as String? ?? '',
          specialty: data['specialty'] as String? ?? '',
          rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
          image: data['image'] as String? ?? '',
          biography: data['biography'] as String? ?? '',
          hospital: data['hospital'] as String? ?? '',
          contact: data['contact'] as String? ?? '',
        );
      }).toList();
    });
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import '../logic/models/doctor.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Doctor>> getDoctors() {
    return _db.collection('doctors').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Doctor(
          name: doc['name'],
          specialty: doc['specialty'],
          rating: doc['rating'],
          image: doc['image'],
          biography: doc['biography'],
          hospital: doc['hospital'],
          contact: doc['contact'],
        );
      }).toList();
    });
  }
}

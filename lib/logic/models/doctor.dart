class Doctor {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String image;
  final String biography;
  final String hospital;
  final String contact;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.image,
    required this.biography,
    required this.hospital,
    required this.contact,
  });


  factory Doctor.fromFirestore(Map<String, dynamic> data, String id) {
    return Doctor(
      id: id,
      name: data['name'] ?? '',
      specialty: data['specialty'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      biography: data['biography'] ?? '',
      hospital: data['hospital'] ?? '',
      contact: data['contact'] ?? '',
    );
  }
}

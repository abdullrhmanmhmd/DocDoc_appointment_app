import 'doctor.dart';

class SampleData {
  SampleData._();

  static final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Sarah Ahmed',
      specialty: 'Cardiologist',
      rating: 4.8,
      image: 'assets/images/doctor1.png',
      biography:
          'Dr. Sarah is an experienced cardiologist with 10 years in the field focusing on preventive care and minimally invasive procedures.',
      hospital: 'Cairo Heart Institute',
      contact: '+20 123 456 789',
    ),
    Doctor(
      name: 'Dr. Omar Hassan',
      specialty: 'Dermatologist',
      rating: 4.6,
      image: 'assets/images/doctor1.png',
      biography:
          'Specializes in dermatologic surgery and cosmetic treatments with more than 12 years of practice.',
      hospital: 'Alexandria Skin Care Center',
      contact: '+20 987 654 321',
    ),
    Doctor(
      name: 'Dr. Nour El Din',
      specialty: 'Pediatrician',
      rating: 4.9,
      image: 'assets/images/doctor1.png',
      biography:
          'Beloved pediatrician known for patient-centered care with a focus on child development.',
      hospital: 'Children\'s Hospital Egypt',
      contact: '+20 555 111 222',
    ),
  ];
}


import 'package:flutter/material.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/widgets/doctor_card_widget.dart';

import '../logic/models/doctor.dart';


class SearchScreen extends StatefulWidget {
  final List<Doctor> doctors;

  const SearchScreen({super.key, required this.doctors});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override


  Widget build(BuildContext context) {


    List<Doctor> filteredDoctors = widget.doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(query.toLowerCase());
    }).toList();


    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        backgroundColor: MyColors.myBlue,
        title: const Text("Search Doctors"),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [





            TextField(
              decoration: InputDecoration(
                hintText: "Search by name or specialty....",
                filled: true,
                fillColor: MyColors.myWhite,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),

            const SizedBox(height: 20),




            Expanded(
              child: filteredDoctors.isEmpty
                  ? const Center(
                child: Text(
                  "No doctors found",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  return DoctorCardWidget(
                    doctor: filteredDoctors[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

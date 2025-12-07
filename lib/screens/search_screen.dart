import 'package:flutter/material.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/widgets/doctor_card_widget.dart';
import '../firestore_service.dart';
import '../logic/models/doctor.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
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
                hintText: "Search by name or specialty...",
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
              child: StreamBuilder<List<Doctor>>(
                stream: FirestoreService().getDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No doctors found",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }



                  final filteredDoctors = snapshot.data!.where((doctor) {
                    return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
                        doctor.specialty.toLowerCase().contains(query.toLowerCase());
                  }).toList();

                  if (filteredDoctors.isEmpty) {
                    return const Center(
                      child: Text(
                        "No doctors found",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }


                  return ListView.builder(
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCardWidget(
                        doctor: filteredDoctors[index],
                      );
                    },
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


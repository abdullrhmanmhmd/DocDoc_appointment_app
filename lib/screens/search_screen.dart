import 'package:flutter/material.dart';
import 'package:doc_app_sw/core/constants/color_theme.dart';
import 'package:doc_app_sw/widgets/doctor_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../logic/services/doctor_service.dart';
import '../logic/models/doctor.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  final DoctorService _doctorService = DoctorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.myWhite,
        elevation: 0,
        leading: SizedBox.shrink(),
        title: Text(
          'Search',
          style: TextStyle(
            color: MyColors.myBlue,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
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
              child: StreamBuilder<List<Doctor>>(
                stream: _doctorService.getDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No doctors found.'));
                  }

                  final filteredDoctors = query.isEmpty
                      ? []
                      : snapshot.data!.where((doctor) {
                          return doctor.name.toLowerCase().contains(
                                query.toLowerCase(),
                              ) ||
                              doctor.specialty.toLowerCase().contains(
                                query.toLowerCase(),
                              );
                        }).toList();

                  if (filteredDoctors.isEmpty) {
                    return Center(
                      child: query.isEmpty
                          ? const Text("Start typing to search for doctors")
                          : const Text("No doctors match your search."),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCardWidget(doctor: filteredDoctors[index]);
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

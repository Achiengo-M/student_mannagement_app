import 'package:flutter/material.dart';
import '../models/student.dart';
import '../database/database_helper.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  List<Student> students = [];
  bool isLoading = false;

  void search(String keyword) async {
    setState(() {
      isLoading = true;
    });

    final data = await DatabaseHelper.instance.searchStudents(keyword);

    setState(() {
      students = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Student"),
        backgroundColor: const Color(0xFF6A0DAD),
      ),
      body: Container(
        color: const Color(0xFFF6F2FF),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                labelText: "Search by name or course",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6A0DAD)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF6A0DAD),
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: search,
            ),

            const SizedBox(height: 15),

            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6A0DAD),
                      ),
                    )
                  : students.isEmpty
                      ? const Center(
                          child: Text(
                            "No students found",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final s = students[index];

                            return Card(
                              elevation: 6,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFF6A0DAD),
                                  child: Text(
                                    s.name.isNotEmpty ? s.name[0] : "?",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  s.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text("${s.course} - ${s.regNo}"),
                              ),
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
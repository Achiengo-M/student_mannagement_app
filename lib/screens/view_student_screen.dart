import 'package:flutter/material.dart';
import '../models/student.dart';
import '../database/database_helper.dart';
import 'edit_student_screen.dart';

class ViewStudentScreen extends StatefulWidget {
  const ViewStudentScreen({super.key});

  @override
  State<ViewStudentScreen> createState() => _ViewStudentScreenState();
}

class _ViewStudentScreenState extends State<ViewStudentScreen> {
  List<Student> students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    setState(() {
      isLoading = true;
    });

    final data = await DatabaseHelper.instance.getStudents();

    setState(() {
      students = data;
      isLoading = false;
    });
  }

  Future<void> deleteStudent(int id) async {
    await DatabaseHelper.instance.deleteStudent(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Student deleted successfully"),
        backgroundColor: Colors.red,
      ),
    );

    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Students"),
        backgroundColor: const Color(0xFF6A0DAD),
      ),
      body: Container(
        color: const Color(0xFFF6F2FF),
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
                        elevation: 8,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
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
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            s.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text("${s.course} - ${s.regNo}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Color(0xFF6A0DAD)),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditStudentScreen(student: s),
                                    ),
                                  );

                                  if (result == true) {
                                    loadStudents();
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  deleteStudent(s.id!);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
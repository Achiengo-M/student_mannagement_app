import 'package:flutter/material.dart';
import '../models/student.dart';
import '../database/database_helper.dart';

class ViewStudentScreen extends StatefulWidget {
  const ViewStudentScreen({super.key});

  @override
  State<ViewStudentScreen> createState() => _ViewStudentScreenState();
}

class _ViewStudentScreenState extends State<ViewStudentScreen> {
  List<Student> students = [];

  void loadStudents() async {
    final data = await DatabaseHelper.instance.getStudents();
    setState(() {
      students = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Students")),

      body: students.isEmpty
          ? const Center(child: Text("No students found"))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final s = students[index];

                return ListTile(
                  title: Text(s.name),
                  subtitle: Text("${s.course} - ${s.regNo}"),
                );
              },
            ),
    );
  }
}
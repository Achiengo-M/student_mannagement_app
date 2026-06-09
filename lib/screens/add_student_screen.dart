import 'package:flutter/material.dart';
import '../models/student.dart';
import '../database/database_helper.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  final regController = TextEditingController();

  void saveStudent() async {
    if (nameController.text.isEmpty ||
        courseController.text.isEmpty ||
        regController.text.isEmpty) return;

    Student student = Student(
      name: nameController.text,
      course: courseController.text,
      regNo: regController.text,
    );

    await DatabaseHelper.instance.insertStudent(student);

    nameController.clear();
    courseController.clear();
    regController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Student saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: courseController,
              decoration: const InputDecoration(labelText: "Course"),
            ),
            TextField(
              controller: regController,
              decoration: const InputDecoration(labelText: "Reg No"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveStudent,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
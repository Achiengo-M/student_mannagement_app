import 'package:flutter/material.dart';
import '../models/student.dart';
import '../database/database_helper.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({super.key, required this.student});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late TextEditingController nameController;
  late TextEditingController courseController;
  late TextEditingController regNoController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    courseController = TextEditingController(text: widget.student.course);
    regNoController = TextEditingController(text: widget.student.regNo);
  }

  void updateStudent() async {
    final updated = Student(
      id: widget.student.id,
      name: nameController.text,
      course: courseController.text,
      regNo: regNoController.text,
    );

    await DatabaseHelper.instance.updateStudent(updated);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Student")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController),
            TextField(controller: courseController),
            TextField(controller: regNoController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateStudent,
              child: const Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
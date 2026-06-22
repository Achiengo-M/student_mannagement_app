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
  late TextEditingController yearController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.student.name);
    courseController = TextEditingController(text: widget.student.course);
    regNoController = TextEditingController(text: widget.student.regNo);
    yearController = TextEditingController(
      text: widget.student.yearOfStudy.toString(),
    );
    phoneController = TextEditingController(
      text: widget.student.phoneNumber,
    );
  }

  Future<void> updateStudent() async {
    final updated = Student(
      id: widget.student.id,
      name: nameController.text,
      course: courseController.text,
      regNo: regNoController.text,
      yearOfStudy: int.tryParse(yearController.text) ?? 0,
      phoneNumber: phoneController.text,
    );

    await DatabaseHelper.instance.updateStudent(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Student updated successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student"),
        backgroundColor: const Color(0xFF6A0DAD),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
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
              controller: regNoController,
              decoration: const InputDecoration(labelText: "Reg No"),
            ),

            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Year of Study"),
            ),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateStudent,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A0DAD),
              ),
              child: const Text("UPDATE STUDENT"),
            ),
          ],
        ),
      ),
    );
  }
}
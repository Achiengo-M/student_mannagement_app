import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/student.dart';
import '../models/attendance.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Student> students = [];

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    final data = await DatabaseHelper.instance.getStudents();
    setState(() {
      students = data;
    });
  }

  Future<void> markAttendance(int studentId, String status) async {
    final attendance = Attendance(
      studentId: studentId,
      date: DateTime.now().toString().split(" ")[0],
      status: status,
    );

    await DatabaseHelper.instance.insertAttendance(attendance);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Marked $status"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        backgroundColor: const Color(0xFF6A0DAD),
      ),

      body: students.isEmpty
          ? const Center(
              child: Text("No students found"),
            )
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(student.name),
                    subtitle: Text(
                      "${student.regNo} | ${student.course}",
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            markAttendance(student.id!, "Present");
                          },
                          child: const Text("P"),
                        ),

                        const SizedBox(width: 5),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            markAttendance(student.id!, "Absent");
                          },
                          child: const Text("A"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
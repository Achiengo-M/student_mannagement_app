import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() =>
      _AttendanceReportScreenState();
}

class _AttendanceReportScreenState
    extends State<AttendanceReportScreen> {
  List<Map<String, dynamic>> attendanceList = [];

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  Future<void> loadAttendance() async {
    final data =
        await DatabaseHelper.instance.getAttendanceWithStudent();

    setState(() {
      attendanceList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Report"),
        backgroundColor: const Color(0xFF6A0DAD),
      ),

      body: attendanceList.isEmpty
          ? const Center(
              child: Text(
                "No attendance records found",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: attendanceList.length,
              itemBuilder: (context, index) {
                final record = attendanceList[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      record['status'] == "Present"
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: record['status'] == "Present"
                          ? Colors.green
                          : Colors.red,
                    ),

                    title: Text(
                      record['name'] ?? "Unknown Student",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      "RegNo: ${record['regNo']}\n"
                      "Date: ${record['date']}\n"
                      "Status: ${record['status']}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
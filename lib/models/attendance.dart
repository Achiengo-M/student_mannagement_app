class Attendance {
  int? attendanceId;
  int studentId;
  String date;
  String status;

  Attendance({
    this.attendanceId,
    required this.studentId,
    required this.date,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'attendanceId': attendanceId,
      'studentId': studentId,
      'date': date,
      'status': status,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      attendanceId: map['attendanceId'],
      studentId: map['studentId'],
      date: map['date'],
      status: map['status'],
    );
  }
}
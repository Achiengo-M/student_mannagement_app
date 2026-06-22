class Student {
  int? id;
  String name;
  String course;
  String regNo;
  int yearOfStudy;
  String phoneNumber;

  Student({
    this.id,
    required this.name,
    required this.course,
    required this.regNo,
    required this.yearOfStudy,
    required this.phoneNumber,
  });

  // Convert Object → Map (for database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'regNo': regNo,
      'yearOfStudy': yearOfStudy,
      'phoneNumber': phoneNumber,
    };
  }

  // Convert Map → Object (from database)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      course: map['course'],
      regNo: map['regNo'],
      yearOfStudy: map['yearOfStudy'] ?? 0,
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
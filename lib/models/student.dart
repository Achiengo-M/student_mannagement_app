class Student {
  int? id;
  String name;
  String course;
  String regNo;

  Student({
    this.id,
    required this.name,
    required this.course,
    required this.regNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'course': course,
      'regNo': regNo,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      course: map['course'],
      regNo: map['regNo'],
    );
  }
}
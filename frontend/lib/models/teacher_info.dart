class TeacherInfo {

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String specialization;
  final String? avatarUrl;

  String get fullName => '$firstName $lastName'.trim();

  TeacherInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.specialization,
    required this.avatarUrl
  });

  factory TeacherInfo.fromJson(Map<String, dynamic> json) {
    return TeacherInfo(
        id: json['id'] ?? 0,
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
        department: json['department'] ?? '',
        specialization: json['specialization'] ?? '',
        avatarUrl: json['avatar'],
    );
  }

}
import 'package:flutter/material.dart';

class InstructorModel {

  final String id;
  final String name;
  final String department;
  final String specialization;
  final String? avatarUrl;

  InstructorModel({
    required this.id,
    required this.name,
    required this.department,
    required this.specialization,
    required this.avatarUrl,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    final firstName = json['first_name'] ?? '';
    final lastName = json['last_name'] ?? '';
    final fullName = '$firstName $lastName'.trim();

    return InstructorModel(
      id: json['id'].toString(),
      name: fullName.isNotEmpty ? fullName : (json['username'] ?? 'Instructor'),
      department: json['department'] ?? '',
      specialization: json['specialization'] ?? '',
      avatarUrl: json['avatar_url'] ?? json['avatar'],
    );
  }

}
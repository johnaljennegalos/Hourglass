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
    required this.avatarUrl
  });

}
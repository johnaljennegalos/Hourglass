import 'package:flutter/material.dart';

class SlotModel {

  final String id;
  final String startTime;
  final String endTime;
  final String date;
  final String location;
  final String capacity;

  SlotModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.location,
    required this.capacity,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    final startTime = json['start_time'] ?? '';
    final endTime = json['end_time'] ?? '';
    final date = json['date'] ?? '';
    final location = json['location'] ?? '';
    final capacity = json['capacity'] ?? '';

    return SlotModel(
      id: json['id'].toString(),
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      date: json['date'] ?? '',
      location: json['location'] ?? '',
      capacity: json['capacity'] ?? '',
    );
  }

}
import 'package:hourglass/models/teacher_info.dart';

class ConsultationSlotDetail {

  final int id;
  final TeacherInfo teacher;
  final String date;
  final String startTime;
  final String endTime;
  final String location;
  final int maxCapacity;
  String get timeSlot => '$startTime - $endTime';

  ConsultationSlotDetail({
    required this.id,
    required this.teacher,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.maxCapacity,
  });

  factory ConsultationSlotDetail.fromJson(Map<String, dynamic> json) {
    return ConsultationSlotDetail(
        id: json['id'] ?? 0,
        teacher: TeacherInfo.fromJson(json['teacher'] ?? {}),
        date: json['date'] ?? '',
        startTime: json['start_time'] ?? '',
        endTime: json['end_time'] ?? '',
        location: json['location'] ?? '',
        maxCapacity: json['max_capacity'] ?? '',
    );
  }


}
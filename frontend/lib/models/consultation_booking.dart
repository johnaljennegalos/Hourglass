import 'package:hourglass/models/consultation_slot_detail.dart';
import 'package:hourglass/models/teacher_info.dart';

class ConsultationBooking {
  final int id;
  final ConsultationSlotDetail slot;
  final String status;
  final String createdAt;
  final bool isPastSlot;
  final String? reason;
  final String? rejectionReason;
  final String firstName;
  final String lastName;
  final String studentEmail;
  final String? studentAvatar;

  bool get isCancellable =>
      !isPastSlot && (status == 'PENDING' || status == 'CONFIRMED');

  ConsultationBooking({
    required this.id,
    required this.slot,
    required this.status,
    required this.createdAt,
    required this.isPastSlot,
    this.reason,
    this.rejectionReason,
    required this.firstName,
    required this.lastName,
    this.studentAvatar,
    required this.studentEmail,
  });

  factory ConsultationBooking.fromJson(Map<String, dynamic> json) {
    ConsultationSlotDetail slotDetail;

    if (json['slot'] is Map<String, dynamic>) {
      slotDetail = ConsultationSlotDetail.fromJson(json['slot']);
    } else {
      slotDetail = ConsultationSlotDetail(
        id: json['slot'] is int ? json['slot'] : 0,
        date: json['slot_date'] ?? '',
        startTime: json['slot_start_time'] ?? '',
        endTime: json['slot_end_time'] ?? '',
        location: json['slot_location'] ?? '',
        teacher: TeacherInfo(
          id: 0,
          firstName: '',
          lastName: '',
          email: '',
          department: '',
          specialization: '',
          avatarUrl: null,
        ),
        maxCapacity: json['max_capacity'] ?? 1,
      );
    }

    return ConsultationBooking(
      id: json['id'] ?? 0,
      slot: slotDetail,
      status: json['status'] ?? 'PENDING',
      createdAt: json['created_at'] ?? '',
      isPastSlot: json['is_past_slot'] ?? false,
      reason: json['reason'],
      rejectionReason: json['rejection_reason'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      studentEmail: json['student_email'] ?? json['email'] ?? '',
      studentAvatar: json['student_avatar'],
    );
  }

}
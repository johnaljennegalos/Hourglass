import 'package:hourglass/models/consultation_slot_detail.dart';

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
    return ConsultationBooking(
      id: json['id'] ?? 0,
      slot: ConsultationSlotDetail.fromJson(json['slot'] ?? {}),
      status: json['status'] ?? 'PENDING',
      createdAt: json['created_at'] ?? '',
      isPastSlot: json['is_past_slot'] ?? false,
      reason: json['reason'],
      rejectionReason: json['rejection_reason'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      studentEmail: json['email'] ?? '',
      studentAvatar: json['student_avatar'],
    );
  }

}
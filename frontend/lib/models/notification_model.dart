import 'package:hourglass/models/notification_booking_details_model.dart';

class NotificationModel {

  final int id;
  final int recipient;
  final int? booking;
  final NotificationBookingDetailsModel? bookingDetails;
  final String title;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.recipient,
    this.booking,
    this.bookingDetails,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      recipient: json['recipient'] ?? 0,
      booking: json['booking'] as int?,
      bookingDetails: json['booking_details'] != null
          ? NotificationBookingDetailsModel.fromJson(json['booking_details'])
          : null,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  NotificationModel copyWith({
    bool? isRead,
  }) {
    return NotificationModel(
      id: id,
      recipient: recipient,
      booking: booking,
      bookingDetails: bookingDetails,
      title: title,
      message: message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }

}
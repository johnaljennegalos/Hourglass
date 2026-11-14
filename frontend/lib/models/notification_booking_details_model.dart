class NotificationBookingDetailsModel {

  final int id;
  final String status;
  final int slotTeacher;
  final String slotDate;
  final String slotStartTime;
  final String slotEndTime;
  final String slotLocation;
  final int slotMaxCapacity;
  final bool slotIsAvailable;

  NotificationBookingDetailsModel({
    required this.id,
    required this.status,
    required this.slotTeacher,
    required this.slotDate,
    required this.slotStartTime,
    required this.slotEndTime,
    required this.slotLocation,
    required this.slotMaxCapacity,
    required this.slotIsAvailable
  });

  factory NotificationBookingDetailsModel.fromJson(Map<String, dynamic> json){
    return NotificationBookingDetailsModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      slotTeacher: json['slot_teacher'] ?? 0,
      slotDate: json['slot_date'] ?? '',
      slotStartTime: json['slot_start_time'] ?? '',
      slotEndTime: json['slot_end_time'] ?? '',
      slotLocation: json['slot_location'] ?? '',
      slotMaxCapacity: json['max_capacity'] ?? 0,
      slotIsAvailable: json['slot_is_available'] ?? false
    );
  }


}
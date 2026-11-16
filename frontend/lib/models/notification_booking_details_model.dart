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

  final int? studentUserId;
  final String? studentNumber;
  final String? studentName;
  final String? studentCourse;
  final String? studentYearLevel;
  final String? studentSection;
  final String? reason;

  NotificationBookingDetailsModel({
    required this.id,
    required this.status,
    required this.slotTeacher,
    required this.slotDate,
    required this.slotStartTime,
    required this.slotEndTime,
    required this.slotLocation,
    required this.slotMaxCapacity,
    required this.slotIsAvailable,
    this.studentUserId,
    this.studentNumber,
    this.studentName,
    this.studentCourse,
    this.studentYearLevel,
    this.studentSection,
    this.reason,
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
      slotMaxCapacity: json['slot_max_capacity'] ?? json['max_capacity'] ?? 0,
      slotIsAvailable: json['slot_is_available'] ?? false,
      studentUserId: json['student_user_id'],
      studentNumber: json['student_number'],
      studentName: json['student_name'],
      studentCourse: json['student_course'],
      studentYearLevel: json['student_year_level'],
      studentSection: json['student_section'],
      reason: json['reason'],
    );
  }


}
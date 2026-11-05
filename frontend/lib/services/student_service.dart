import 'dart:convert';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

//create equivalent method for every method define in views later

class StudentService {

  static Future<http.Response> registerStudent(
      String firstName,
      String lastName,
      String username,
      String email,
      String password,
      ) async {

    final Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password
    };

    try {
      final http.Response response = await ApiService.post(
        '/student/register/',
        body: body,
      );

      return response;
    } catch (e) {
      print('An error occurred during student registration: $e');
      rethrow;
    }

  }

  static Future<Map<String, dynamic>?> getProfile() async {

    String? authToken = AuthService.accessToken;

    if(authToken == null){
      print('Cannot fetch student profile: User is not authenticated.');
      return null;
    }

    try{

      final response = await ApiService.get('/students/me/profile-metrics/', token: authToken);

      if (response.statusCode == 200){
        final Map<String, dynamic> studentProfileData = jsonDecode(response.body);
        return studentProfileData;
      } else if (response.statusCode == 401){
        print('Unauthorized: Access token expired or invalid.');
        return null;
      } else if (response.statusCode == 403) {
        print('Forbidden: Current user is not registered as a student.');
        return null;
      } else {
        print('Failed to get profile [${response.statusCode}]: ${response.body}');
        return null;
      }

    } catch (e){
      print('An error occurred while getting the profile: $e');
      return null;
    }

  }

  static Future<bool> updateProfile(Map<String, dynamic> updateData) async {

    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch student: User is not authenticated.');
      return false;
    }

    try{
      final response = await ApiService.patch('/student/me/profile/', body: updateData, token: authToken);

      print('UPDATE PROFILE STATUS: ${response.statusCode}');
      print('UPDATE PROFILE RESPONSE: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Profile updated successfully.');
        return true;
      } else if (response.statusCode == 400) {
        print('Validation error [400]: ${response.body}');
        return false;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('Unauthorized [401]: Access token expired.');
        return false;
      } else {
        print('Failed to update profile [${response.statusCode}]: ${response.body}');
        return false;
      }
    } catch (e) {
      print('An error occurred while updating profile: $e');
      return false;
    }

  }

  static Future<List<dynamic>?> getInstructors({String? query}) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null) {
      print('Cannot fetch instructors: User is not authenticated.');
      return null;
    }

    try{

      final String path = (query != null && query.trim().isNotEmpty)
          ? '/instructor/?search=${Uri.encodeComponent(query.trim())}'
          : '/instructor/';

      final response = await ApiService.get(path, token: authToken);

      if (response.statusCode == 200) {
        final List<dynamic> instructorList = jsonDecode(response.body);
        return instructorList;
      } else if (response.statusCode == 401) {
        print('Unauthorized: Access token expired or invalid.');
        return null;
      } else if (response.statusCode == 403) {
        print('Forbidden: Role permissions error.');
        return null;
      } else {
        print('Failed to get instructors list [${response.statusCode}]: ${response.body}');
        return null;
      }

    } catch (e) {
      print('An error occurred while getting the instructors profile: $e');
      return null;
    }


  }

  static Future<Map<String, dynamic>?> getInstructorDetails(int instructorId) async {

    String? authToken = AuthService.accessToken;

    if (authToken == null) {
      print('Cannot fetch instructors details: User is not authenticated.');
      return null;
    }

    try{

      final response = await ApiService.get('/instructor/$instructorId/', token: authToken);

      if (response.statusCode == 200) {
        final Map<String, dynamic> instructorDetails = jsonDecode(response.body);
        return instructorDetails;
      } else if (response.statusCode == 404) {
        print('Instructor with ID $instructorId not found.');
        return null;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('Forbidden: Role permissions error.');
        return null;
      } else {
        print('Failed to get instructors list [${response.statusCode}]: ${response.body}');
        return null;
      }

    } catch (e) {
      print('An error occurred while getting the instructors profile: $e');
      return null;
    }

  }

  static Future<List<dynamic>?> getAvailableSlot(int instructorId) async {

    String? authToken = AuthService.accessToken;

    if (authToken == null) {
      print('Cannot fetch available slot: User is not authenticated.');
      return null;
    }

    try{

      final response = await ApiService.get(
        '/slots/?instructor=$instructorId',
        token: authToken,
      );

      if (response.statusCode == 200) {
        final List<dynamic> availableSlots = jsonDecode(response.body);
        return availableSlots;
      } else if (response.statusCode == 400) {
        print('Bad request');
        return null;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('Forbidden: Role permissions error.');
        return null;
      } else {
        print('Failed to get instructors available slot [${response.statusCode}]: ${response.body}');
        return null;
      }

    } catch (e) {
      print('An error occurred while getting the instructors available slot: $e');
      return null;
    }

  }

  static Future<bool> createBooking(Map<String, dynamic> bookingData) async {

    String? authToken = AuthService.accessToken;

    if (authToken == null) {
      print('Cannot create booking: User is not authenticated.');
      return false;
    }

    try{

      final response = await ApiService.post('/bookings/', body: bookingData, token: authToken);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Booking created successfully!');
        return true;
      } else if (response.statusCode == 400) {
        print('Booking validation error [400]: ${response.body}');
        return false;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('Forbidden: Role permissions error.');
        return false;
      } else {
        print('Failed to create a booking [${response.statusCode}]: ${response.body}');
        return false;
      }

    } catch (e) {
      print('Error creating booking: $e');
      return false;
    }

  }

  static Future<bool> updatStudentAvatar(File imageFile) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot upload avatar: User is not authenticated.');
      return false;
    }

    try {
      final response = await ApiService.patchMultipart(
        '/student/me/profile/',
        file: imageFile,
        fileFieldName: 'avatar',
        token: authToken,
      );
      print('AVATAR UPLOAD STATUS: ${response.statusCode}');
      print('AVATAR UPLOAD RESPONSE: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed avatar upload (${response.statusCode}): ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception during avatar upload: $e');
      return false;
    }
  }

  static Future<List<dynamic>?> getBookingHistory() async {

    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch history: User is not authenticated.');
      return null;
    }

    try {

      final response = await ApiService.get(
        '/students/me/history/',
        token: authToken
      );

      if (response.statusCode == 200) {
        final List<dynamic> slotHistory = jsonDecode(response.body);
        return slotHistory;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('Forbidden: Role permissions error.');
        return null;
      } else {
        print('Failed to fetch booking history (${response.statusCode}): ${response.body}');
        return null;
      }

    } catch (e) {
      print('Error fetching history: $e');
      return null;
    }

  }

  static Future<bool> cancelBooking(int bookingId) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot cancel booking: User is not authenticated.');
      return false;
    }

    try {

      final response  = await ApiService.patch(
        '/bookings/$bookingId/cancel/',
        token: authToken
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        print('Failed to cancel booking (${response.statusCode}): ${response.body}');
        return false;
      }

    } catch (e) {
      print('Error cancelling booking: $e');
      return false;
    }

  }

}
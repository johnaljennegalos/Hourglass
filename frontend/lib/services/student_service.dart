import 'dart:convert';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:http/http.dart' as http;

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

  static Future<List<dynamic>?> getInstructors() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null) {
      print('Cannot fetch instructors: User is not authenticated.');
      return null;
    }

    try{

      final response = await ApiService.get('/instructor/', token: authToken);

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

}
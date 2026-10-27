import 'dart:convert';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

//create equivalent method for every method define in views later

class InstructorService {

  static Future<http.Response> registerInstructor(String firstName, String lastName, String username, String email, String password) async{

    final Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'email': email,
      'password': password
    };

    try {
      final http.Response response = await ApiService.post(
        '/instructor/register/',
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

    if (authToken == null){
      print('Cannot fetch profile: User is not authenticated.');
      return null;
    }

    try{
      final response = await ApiService.get('/instructor/me/profile/', token: authToken);

      if (response.statusCode == 200){
        final Map<String, dynamic> profileData = jsonDecode(response.body);
        return profileData;
      } else if (response.statusCode == 401){
        print('Unauthorized: Access token expired or invalid.');
        return null;
      } else if (response.statusCode == 403){
        print('Forbidden: Current user is not registered as an instructor.');
        return null;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print('An error occurred while fetching instructor profile: $e');
      return null;
    }

  }


  static Future<bool> updateProfile(Map<String, dynamic> updateData) async {

    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch profile: User is not authenticated.');
      return false;
    }

    try{
      final response = await ApiService.patch('/instructor/me/profile/', body: updateData, token: authToken);

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

  static Future<bool> createConsultationSlot(Map<String, dynamic> slotData) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot create slot: User is not authenticated.');
      return false;
    }

    try{

      final response = await ApiService.post(
        '/instructor/slots/',
        body: slotData,
        token: authToken
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print('Failed [${response.statusCode}]: ${response.body}');
        return false;
      }

    } catch (e) {
      print('An error occurred while creating consultation slot: $e');
      return false;
    }
  }

  static Future<List<dynamic>> getSlots() async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot fetch profile: User is not authenticated.');
      return [];
    }

    try{

      final response = await ApiService.get(
        '/instructor/me/slots/',
        token: authToken
      );

      if (response.statusCode == 200) {
        final List<dynamic> slotListData = jsonDecode(response.body);
        return slotListData;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('Unauthorized: Access token expired or invalid.');
        return [];
      } else {
        print(response.statusCode);
        return [];
      }

    } catch (e) {
      print('An error occurred while fetching consultation slot: $e');
      return [];
    }


  }


  static Future<bool> updateConsultationSlot(int slotId, Map<String, dynamic> data) async {

    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot update slot: User is not authenticated.');
      return false;
    }

    try{
      
      final response = await ApiService.patch(
        '/instructor/slots/$slotId/',
        token: authToken,
        body: data
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        print('Failed to update slot (${response.statusCode}): ${response.body}');
        return false;
      }
      
    } catch (e) {

      print('Error updating consultation slot: $e');
      return false;
    }
    
  }


  static Future<bool> deleteConsultationSlot(int slotId) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot delete slot: User is not authenticated.');
      return false;
    }

    try{

      final response = await ApiService.delete(
        '/instructor/slots/$slotId/',
        token: authToken
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete slot (${response.statusCode}): ${response.body}');
        return false;
      }

    } catch (e) {
      print('Error deleting consultation slot: $e');
      return false;
    }

  }


  static Future<bool> updatInstructoreAvatar(File imageFile) async {
    String? authToken = AuthService.accessToken;

    if (authToken == null){
      print('Cannot upload avatar: User is not authenticated.');
      return false;
    }

    try {
      final response = await ApiService.patchMultipart(
        '/instructor/me/profile/',
        file: imageFile,
        fileFieldName: 'avatar',
        token: authToken,
      );

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

}
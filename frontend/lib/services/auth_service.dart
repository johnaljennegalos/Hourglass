import 'dart:convert';
import '../services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static String? _accessToken;

  static String? get accessToken => _accessToken;
  static const _storage = FlutterSecureStorage();

  static Future<String?> signInUser(String username, String password) async {
    try{
      final response = await ApiService.post(
        '/auth/sign_in/',
        body: {
          'username' : username,
          'password' : password
        },
      );

      if (response.statusCode == 200){
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        await _storage.write(key: 'jwt_access', value: responseData['access']);
        await _storage.write(key: 'jwt_refresh', value: responseData['refresh']);
        await _storage.write(key: 'role', value: responseData['role']);

        _accessToken = responseData['access'];

        print('Token successfully extracted: $_accessToken');
        return responseData['role'] as String?;

      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        print('Sign In failed [${response.statusCode}]: ${errorData['detail'] ?? response.body}');
        return null;
      }
    } catch (e) {
      print('An error occurred: $e');
      return null;
    }
  }

  static Future<bool> tryAutoLogin() async {

    try{
      final storedToken = await _storage.read(key: 'jwt_access');
      if (storedToken != null){
        _accessToken = storedToken;
        return true;
      } else {
        _accessToken = null;
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }

  }

  static Future<void> logout() async {

    try{
      await _storage.deleteAll();
      _accessToken = null;
      print('User logged out cleanly.');
    } catch (e) {
      print('Error during log out: $e');
      _accessToken = null;
    }

  }

}
import 'dart:convert';
import '../services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static String? _accessToken;

  static String? get accessToken => _accessToken;
  static const _storage = FlutterSecureStorage();

  static Future<bool> loginUser(String username, String password) async {
    try{
      final response = await ApiService.post(
        '/token/',
        body: {
          'username' : username,
          'password' : password
        },
      );

      if (response.statusCode == 200){
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        await _storage.write(key: 'jwt_access', value: responseData['access']);
        await _storage.write(key: 'jwt_refresh', value: responseData['refresh']);

        _accessToken = responseData['access'];

        print('Token successfully extracted: $_accessToken');
        return true;

      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        print('Login failed [${response.statusCode}]: ${errorData['detail'] ?? response.body}');
        return false;
      }
    } catch (e) {
      print('An error occurred: $e');
      return false;
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
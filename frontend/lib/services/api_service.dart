import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService{
  static const String baseUrl = 'http://192.168.1.3:8000/api';

  static Future<http.Response> post(
      String endpoint,
      {required Map<String, dynamic> body, String? token,}
      ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type' : 'application/json',
      'Accept' : 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));
  }

  static Future<http.Response> get(String endpoint, {String? token,}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization' : 'Bearer $token',
    };

    return await http.get(
      url, headers: headers
    ).timeout(const Duration(seconds: 10));
  }

  static Future<int> checkConnection() async {
    try{
      final response = await http.get(
        Uri.parse('$baseUrl/instructor/me/profile/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ).timeout(const Duration(seconds: 5));

      return response.statusCode;
    } catch(e){
      return -1;
    }
  }

}
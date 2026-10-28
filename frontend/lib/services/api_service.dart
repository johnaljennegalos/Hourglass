import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ApiService{
  static const String baseUrl = 'http://192.168.1.4:8000/api';

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

  static Future<http.Response> patch(String endpoint, {required Map<String, dynamic> body, String? token,}) async {

    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization' : 'Bearer $token',
    };

    return await http.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 10));

  }

  static Future<http.Response> delete(String endpoint, {Map<String, dynamic>? body, String? token,}) async {

    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization' : 'Bearer $token',
    };

    return await http.delete(
      url,
      headers: headers,
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


  static Future<http.Response> patchMultipart(
      String endpoint, {
        required File file,
        required String fileFieldName,
        String? token,
      }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('PATCH', url);

    request.headers.addAll({
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        fileFieldName,
        file.path,
        filename: path.basename(file.path),
      ),
    );

    final streamedResponse = await request.send().timeout(const Duration(seconds: 15));
    return await http.Response.fromStream(streamedResponse);
  }

}
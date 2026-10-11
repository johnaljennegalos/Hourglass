import 'package:http/http.dart' as http;

class ApiService{
  static const String baseUrl = 'http://192.168.1.3:8000/api';

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
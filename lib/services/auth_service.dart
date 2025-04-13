import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  AuthService({this.baseUrl = 'https://waterqualityazaz.com/api'});

  Future<Map<String, dynamic>> login(String phoneNumber, String password) async {
  final url = Uri.parse('$baseUrl/auth/login');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'phoneNumber': phoneNumber,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to login: ${response.statusCode} - ${response.body}');
  }
}

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/api/Auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: userData.map((key, value) => MapEntry(key, value.toString())),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<void> forgotPassword(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/api/Auth/forgotpassword');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'phoneNumber': phoneNumber},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send password reset request: ${response.body}');
    }
  }

  Future<bool> verifyCode(String phoneNumber, String code) async {
    final url = Uri.parse('$baseUrl/api/Twilio/verify-code');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'phoneNumber': phoneNumber,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['status'] == 'approved';
    } else {
      throw Exception('Failed to verify code: ${response.body}');
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      final responseData = jsonDecode(response.body);
      if (responseData.containsKey('token') && responseData['token'] != null) {
        // Save the token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', responseData['token']);
      }
      return responseData;
    } else {
      throw Exception('Failed to login: ${response.statusCode} - ${response.body}');
    }
  }

  Future<bool> register({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String locationLatitude,
    required String locationLongitude,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/Auth/register');
    final body = {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "address": address,
      "locationLattitude": locationLatitude,
      "locationLongitude": locationLongitude,
      "password": password,
      "confirmPassword": confirmPassword,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print("User registered successfully!");
      return true;
    } else {
      print("Failed to register: ${response.body}");
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final url = Uri.parse('$baseUrl/User/Profile');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user profile: ${response.body}');
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


  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
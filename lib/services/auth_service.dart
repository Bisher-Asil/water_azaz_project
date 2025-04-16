import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_azaz_project/helpers/api_url.dart';

class AuthService {
  final String baseUrl;

  AuthService({this.baseUrl = ApiUrl.baseUrl});

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

  Future<bool> register(RegisterDto registerDto) async {
    final url = Uri.parse('$baseUrl/Auth/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(registerDto.toJson());

    final response = await http.post(url, headers: headers, body: body);
    if(response.statusCode == 200){
      return true; // Registration successful
    } else {
      print('Failed to register: ${response.statusCode} - ${response.body}');
      return false; // Registration failed
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


  /*Future<void> forgotPassword(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/api/Auth/forgotpassword');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'phoneNumber': phoneNumber},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send password reset request: ${response.body}');
    }
  }*/

  
  ///call this method to get the security question for the user who forget their password
  ///and want to reset it using the security question
    Future<String?> getSecurityQuestion(String phoneNumber) async {
    final url = Uri.parse('$baseUrl/User/user-security-question?phoneNumber=$phoneNumber');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      var responseFiltered = jsonResponse['securitQuestion'] ?? '';
      if (responseFiltered.isEmpty) {
        print('Security question not found for the provided phone number.');
        return null;
      } 
      return responseFiltered;
    } else if (response.statusCode == 404) {
      print('User not found. Check the phone number.');
      return null;
    } else {
      print('Failed to fetch security question: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  ///call this method to verify the security question answer
  ///and get the code to reset the password
  Future<http.Response> verifySecurityQuestion(SecurityQuestionDto securityQuestionDto) async {
    final url = Uri.parse('$baseUrl/User/check-security-answer');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(securityQuestionDto.toJson());

    final response = await http.post(url, headers: headers, body: body);
    return response;
  }

  ///call this method to reset the password using the security question answer
  ///and the new password
  Future<bool> resetPassword(ResetPasswordDto resetPasswordDto) async {
    final url = Uri.parse('$baseUrl/User/forgotpassword');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(resetPasswordDto.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Password reset successful.');
      return true;
    } else {
      print('Password reset failed: ${response.statusCode} - ${response.body}');
      return false;
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

class SecurityQuestionResponse {
  final String securityQuestion;

  SecurityQuestionResponse({required this.securityQuestion});

  factory SecurityQuestionResponse.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionResponse(
      securityQuestion: json['SecuritQuestion'] ?? '',
    );
  }
}

class SecurityQuestionDto {
  final String phoneNumber;
  final String securityQuestionAnswer;

  SecurityQuestionDto({
    required this.phoneNumber,
    required this.securityQuestionAnswer,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'securityQuestionAnswer': securityQuestionAnswer,
    };
  }
}

class ResetPasswordDto {
  final String phoneNumber;
  final String newPassword;
  final String code;

  ResetPasswordDto({
    required this.phoneNumber,
    required this.newPassword,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'newPassword': newPassword,
      'code': code,
    };
  }
}

class RegisterDto {
  final String phoneNumber;
  final String fullName;
  final String securityQuestion;
  final String securityQuestionAnswer;
  final String address;
  final String locationLatitude;
  final String locationLongitude;
  final String password;
  final String confirmPassword;

  RegisterDto({
    required this.phoneNumber,
    required this.fullName,
    required this.securityQuestion,
    required this.securityQuestionAnswer,
    required this.address,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      'securityQuestion': securityQuestion,
      'securityQuestionAnswer': securityQuestionAnswer,
      'address': address,
      'locationLattitude': locationLatitude,
      'locationLongitude': locationLongitude,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:water_azaz_project/helpers/api_url.dart';

 class QualityService {
  final String baseUrl;

  QualityService({this.baseUrl = ApiUrl.baseUrl});

  static Future<bool> postWaterQuality(String token, String waterColorText, String waterTasteText) async {
  final url = Uri.parse('${ApiUrl.baseUrl}/WaterQuality');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'WaterColorText': waterColorText,
    'WaterTasteText': waterTasteText,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return true; // Successfully submitted
    } else {
      print('Failed to submit water quality data: ${response.statusCode}');
      print('Response: ${response.body}');
      return false; // Failed to submit
    }
  } catch (e) {
    print('Error occurred while submitting water quality data: $e');
    return false; // Handle network errors or exceptions
  }
}
}
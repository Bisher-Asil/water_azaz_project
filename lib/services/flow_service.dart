import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:water_azaz_project/helpers/api_url.dart';

class FlowService {
  final String baseUrl;

  FlowService({this.baseUrl = ApiUrl.baseUrl});

static Future<bool> postWaterFlow(String token, String waterFlowTimesText, String expectedWaterFlow) async {
  final url = Uri.parse('${ApiUrl.baseUrl}/WaterFlow');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  final body = jsonEncode({
    'WaterFlowTimesText': waterFlowTimesText,
    'ExpectedWaterFlow': expectedWaterFlow,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Water flow data submitted successfully!');
      return true; // Successfully submitted
    } else {
      print('Failed to submit water flow data: ${response.statusCode}');
      print('Response: ${response.body}');
      return false; // Failed to submit
    }
  } catch (e) {
    print('Error occurred while submitting water flow data: $e');
    return false;
  }
}
}
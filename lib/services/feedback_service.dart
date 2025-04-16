import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:water_azaz_project/helpers/api_url.dart';

class FeedbackService {
  final String baseUrl;

  FeedbackService({this.baseUrl = ApiUrl.baseUrl});


static Future<bool> postFeedback(String token, String content, File? file) async {
  final url = Uri.parse('${ApiUrl.baseUrl}/FeedBack');
  final headers = {
    'Authorization': 'Bearer $token',
  };

  // Create a multipart request
  final request = http.MultipartRequest('POST', url)
    ..headers.addAll(headers)
    ..fields['Contnet'] = content;

  // Attach the file if provided
  if (file != null) {
    final fileStream = http.ByteStream(file.openRead());
    final length = await file.length();
    final multipartFile = http.MultipartFile(
      'File',
      fileStream,
      length,
      filename: file.path.split('/').last,
    );
    request.files.add(multipartFile);
  }

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Feedback submitted successfully!');
      return true; // Successfully submitted
    } else {
      print('Failed to submit feedback: ${response.statusCode}');
      return false; // Failed to submit
    }
  } catch (e) {
    print('Error occurred while submitting feedback: $e');
    return false; // Handle network errors or exceptions
  }
}
}
import 'dart:convert';
import 'package:chatgpt_clone/constants/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> getResponseFromGemini(String query) async {
    final String url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$API_KEY";
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": query}
          ]
        }
      ]
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      return jsonDecode(response.body);
    } catch (error) {
      throw Exception(error);
    }
  }
}

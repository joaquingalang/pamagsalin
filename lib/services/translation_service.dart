import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String baseUrl = "https://kruokruo-nllb-200-kpm-api.hf.space";

  /// Health check
  Future<String> healthCheck() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed health check: ${response.statusCode}");
    }
  }

  /// Translate text
  Future<String> translate(String text) async {
    // Encode text for URL
    final encodedText = Uri.encodeQueryComponent(text);
    final url = Uri.parse("$baseUrl/translate?text=$encodedText");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["translation"] ?? "(no translation)";
    } else {
      throw Exception("Translation failed: ${response.statusCode}");
    }
  }
}
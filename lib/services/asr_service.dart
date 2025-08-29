import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AsrService {

  static const baseUrl = 'https://kruokruo-wav2vec2-kap-api.hf.space';

  Future<String> healthCheck() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed health check: ${response.statusCode}");
    }
  }

  Future<String?> transcribeAudio(File audioFile) async {
    final uri = Uri.parse('$baseUrl/transcribe');
    final request = http.MultipartRequest("POST", uri);

    request.files.add(
      await http.MultipartFile.fromPath("file", audioFile.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(respStr);
      return data['cleaned_transcription'];
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAiApi {
  final String apiKey;

  OpenAiApi({required this.apiKey});

  Future<String> sendMessage(String message) async {
    final Map<String, dynamic> requestBody = {
      'max_tokens': 50,
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': message}
      ]
    };

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String text = data['choices'][0]['message']['content'];
      return text;
    } else {
      throw Exception('Failed to send message');
    }
  }
}

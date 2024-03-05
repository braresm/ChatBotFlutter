import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatMessage extends StatelessWidget {
  final bool isMyMessage;
  final String text;
  final FlutterTts flutterTts = FlutterTts();

  ChatMessage({
    super.key,
    required this.isMyMessage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _speakMessage(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isMyMessage ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Future<void> _speakMessage(String message) async {
    flutterTts.speak(message);
  }
}

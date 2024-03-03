import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatbot/blocs/chat_bloc.dart';
import 'package:flutter_chatbot/components/chat_message.dart';
import 'package:flutter_chatbot/components/record_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, List<ChatMessage>>(
        builder: (context, messages) {
      // Access the current state of the chat screen
      final chatState = BlocProvider.of<ChatBloc>(context).chatState;
      final isBotTyping = chatState == ChatState.loading;

      return _buildChatInterface(messages, isBotTyping);
    });
  }

  Widget _buildChatInterface(List<ChatMessage> messages, bool isBotTyping) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: messages.length + (isBotTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == messages.length) {
                return _buildTypingIndicator();
              } else {
                final message = messages[index];
                return ChatMessage(
                  text: message.text,
                  isMyMessage: message.isMyMessage,
                );
              }
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RecordButton(
                onRecordedText: (recordedText) {
                  BlocProvider.of<ChatBloc>(context).sendMessage(recordedText);
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTypingIndicator() {
    return const ListTile(
      leading: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      title: Text("Bot is typing..."),
    );
  }
}

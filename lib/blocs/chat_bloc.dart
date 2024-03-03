import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatbot/components/chat_message.dart';
import 'package:flutter_chatbot/services/open_ai_api.dart';

enum ChatState { initial, loading, success, failure }

class ChatBloc extends Cubit<List<ChatMessage>> {
  final OpenAiApi openAiApi; // Initialize your OpenAI API service here

  ChatBloc({required this.openAiApi}) : super([]);

  // State to track the current state of the chat screen
  ChatState _chatState = ChatState.initial;

  // Getter for accessing the current chat screen state
  ChatState get chatState => _chatState;

  Future<void> sendMessage(String message) async {
    // Add the user message
    addMessage(ChatMessage(isMyMessage: true, text: message));

    // Update the state to loading while calling the OpenAI API
    updateScreenState(ChatState.loading);

    try {
      final response = await openAiApi.sendMessage(message);

      // Add the message received from OpenAI API call
      addMessage(ChatMessage(isMyMessage: false, text: response));

      // Update the state
      updateScreenState(ChatState.success);
    } catch (e) {
      updateScreenState(ChatState.failure);
    }
  }

  // Method to add a new message to the chat
  void addMessage(ChatMessage message) {
    emit([...state, message]);
  }

  // Method to update the chat screen state
  void updateScreenState(ChatState newState) {
    _chatState = newState;
    emit(state); // Emitting current state of chat messages
  }
}

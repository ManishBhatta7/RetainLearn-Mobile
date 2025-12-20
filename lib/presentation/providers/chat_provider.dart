import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/repository_providers.dart';

class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final bool isStreaming;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    this.isStreaming = false,
    required this.timestamp,
  });

  ChatMessage copyWith({
    String? id,
    String? content,
    bool? isUser,
    bool? isStreaming,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
      isStreaming: isStreaming ?? this.isStreaming,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref ref;

  ChatNotifier(this.ref) : super(const ChatState());

  Future<void> sendMessage(String text, {List<String> contextIds = const []}) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().toString(),
      content: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    // Optimistically add user message
    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isLoading: true,
      error: null,
    );

    try {
      final repository = ref.read(geminiRepositoryProvider);
      
      // Create a placeholder for the bot response
      final botMsgId = "bot_${DateTime.now().millisecondsSinceEpoch}";
      final botMsgPlaceholder = ChatMessage(
        id: botMsgId,
        content: "",
        isUser: false,
        isStreaming: true,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, botMsgPlaceholder],
      );

      // Listen to the stream
      final stream = repository.sendChatMessage(
        message: text,
        contextIds: contextIds,
      );

      String accumulatedText = "";

      await for (final chunk in stream) {
        accumulatedText += chunk;
        
        // Update the last message (the bot placeholder)
        state = state.copyWith(
          messages: state.messages.map((msg) {
            if (msg.id == botMsgId) {
              return msg.copyWith(content: accumulatedText);
            }
            return msg;
          }).toList(),
        );
      }

      // Finalize streaming state
      state = state.copyWith(
        isLoading: false,
        messages: state.messages.map((msg) {
          if (msg.id == botMsgId) {
            return msg.copyWith(isStreaming: false);
          }
          return msg;
        }).toList(),
      );

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  void clearChat() {
    state = const ChatState();
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(ref);
});

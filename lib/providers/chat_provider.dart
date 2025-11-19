import 'package:finbuddy_ai/models/message.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/services/ai_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

// ============== SERVICE PROVIDERS ==============

@riverpod
AIService aiService(Ref ref) {
  return AIService();
}

// ============== CURRENT CONVERSATION PROVIDER ==============

@riverpod
class CurrentConversationId extends _$CurrentConversationId {
  @override
  String? build() => null;

  void setConversation(String? conversationId) {
    state = conversationId;
  }

  void clearConversation() {
    state = null;
  }
}

// ============== MESSAGES STREAM PROVIDER ==============

@riverpod
Stream<List> conversationMessages(
  Ref ref,
  String userId,
  String conversationId,
) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.streamMessages(userId, conversationId);
}

// ============== CHAT ACTIONS PROVIDER ==============

@riverpod
class ChatActions extends _$ChatActions {
  @override
  FutureOr build() {}

  /// Send a message and get AI response
  Future sendMessage({
    required String text,
    required String userId,
    String? conversationId,
  }) async {
    // Keep provider alive during async operations
    final link = ref.keepAlive();

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final firestoreService = ref.read(firestoreServiceProvider);
      final aiService = ref.read(aiServiceProvider);
      final user = await ref.read(currentUserProvider.future);

      // Create conversation if it doesn't exist
      String actualConversationId = conversationId ?? '';
      if (actualConversationId.isEmpty) {
        actualConversationId = await firestoreService.createConversation(
          userId: userId,
          firstMessage: text,
        );
        ref
            .read(currentConversationIdProvider.notifier)
            .setConversation(actualConversationId);
      }

      // Create and save user message
      final userMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: actualConversationId,
        text: text,
        sender: MessageSender.user,
        timestamp: DateTime.now(),
        userId: userId,
      );

      await firestoreService.saveMessage(userMessage, userId);

      // Get conversation history for context
      final messages = await firestoreService.getMessages(
        userId,
        actualConversationId,
        limit: 10, // Last 10 messages for context
      );

      // Initialize AI session with context
      aiService.startNewSession(
        user: user,
        history: messages
            .take(messages.length - 1)
            .toList(), // Exclude current message
      );

      // Get AI response
      final aiResponse = await aiService.sendMessage(text);

      // Create and save AI message
      final aiMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: actualConversationId,
        text: aiResponse,
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
        userId: userId,
      );

      await firestoreService.saveMessage(aiMessage, userId);
    });

    // Close the keep-alive link after async work is done
    link.close();
  }

  /// Send a message with streaming AI response
  Stream sendMessageStream({
    required String text,
    required String userId,
    required String conversationId,
  }) async* {
    final aiService = ref.read(aiServiceProvider);
    final user = await ref.read(currentUserProvider.future);

    // Initialize AI session
    aiService.startNewSession(user: user);

    // Stream AI response
    yield* aiService.sendMessageStream(text);
  }

  /// Start a new conversation
  Future startNewConversation({
    required String userId,
    required String firstMessage,
  }) async {
    // Keep provider alive during async operations
    final link = ref.keepAlive();

    try {
      final firestoreService = ref.read(firestoreServiceProvider);

      final conversationId = await firestoreService.createConversation(
        userId: userId,
        firstMessage: firstMessage,
      );

      ref
          .read(currentConversationIdProvider.notifier)
          .setConversation(conversationId);

      return conversationId;
    } finally {
      // Close the keep-alive link after async work is done
      link.close();
    }
  }
}

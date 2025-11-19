import 'package:finbuddy_ai/models/app_user.dart';
import 'package:finbuddy_ai/models/message.dart';
import 'package:finbuddy_ai/utils/constants.dart';
import 'package:firebase_ai/firebase_ai.dart';

/// AI service using Firebase AI (Gemini)
/// Handles all AI interactions
class AIService {
  // This model is for general, non-chat tasks like title generation
  late final GenerativeModel _defaultModel;

  // This holds the active chat session
  ChatSession? _chatSession;

  AIService() {
    _initializeDefaultModel();
  }

  /// Initializes the default model used for general-purpose, non-chat requests.
  void _initializeDefaultModel() {
    _defaultModel = FirebaseAI.googleAI().generativeModel(
      model: AppConstants.geminiModel,
      generationConfig: GenerationConfig(
        temperature: AppConstants.aiTemperature,
        maxOutputTokens: AppConstants.aiMaxOutputTokens,
        topK: AppConstants.topK,
        topP: AppConstants.topP,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium, null),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium, null),
      ],
    );
  }

  /// Starts a new chat session.
  /// This creates a new model instance configured with the specific
  /// user context and history.
  void startNewSession({AppUser? user, List? history}) {
    // 1. Build the dynamic system instruction based on the user
    final systemInstruction = _buildSystemInstruction(user);

    // 2. Map the chat history (if any) to the Content format
    final chatHistory =
        history?.map((message) {
          return Content(
            message.sender == MessageSender.user ? 'user' : 'model',
            [TextPart(message.text)],
          );
        }).toList();

    // 3. Create a NEW model instance specifically for this chat session.
    final sessionModel = FirebaseAI.googleAI().generativeModel(
      model: AppConstants.geminiModel,
      generationConfig: GenerationConfig(
        temperature: AppConstants.aiTemperature,
        maxOutputTokens: AppConstants.aiMaxOutputTokens,
        topK: AppConstants.topK,
        topP: AppConstants.topP,
      ),
      // Pass the dynamic, session-specific system instruction here
      systemInstruction: Content.system(systemInstruction),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium, null),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium, null),
      ],
    );

    // 4. Start the chat using this new session-specific model
    _chatSession = sessionModel.startChat(history: chatHistory);
  }

  /// Helper to build the system instruction string with user context
  String _buildSystemInstruction(AppUser? user) {
    final basePrompt = AIPrompts.systemPrompt;
    final userContext = AIPrompts.getUserContextPrompt(user);

    return '$basePrompt$userContext';
  }

  /// Send a message and get a single (non-streaming) response
  Future<String> sendMessage(String message) async {
    if (_chatSession == null) {
      // Start a session with no user or history if one doesn't exist
      startNewSession();
    }

    try {
      final response = await _chatSession!.sendMessage(Content.text(message));

      return response.text ??
          'I apologize, but I couldn\'t generate a response. Please try again.';
    } catch (e) {
      throw AIException('Failed to get AI response: ${e.toString()}');
    }
  }

  /// Send a message and get a streaming response
  Stream<String> sendMessageStream(String message) async* {
    if (_chatSession == null) {
      // Start a session with no user or history if one doesn't exist
      startNewSession();
    }

    try {
      // Get the stream of responses
      final responseStream = _chatSession!.sendMessageStream(
        Content.text(message),
      );

      // Yield each chunk of text as it arrives
      await for (final chunk in responseStream) {
        if (chunk.text != null) {
          yield chunk.text!;
        }
      }
    } catch (e) {
      throw AIException('Failed to stream AI response: ${e.toString()}');
    }
  }

  /// Generate a conversation title from the first message
  Future<String> generateConversationTitle(String firstMessage) async {
    try {
      final prompt = '''
Based on this message, generate a short, descriptive title (max 6 words):
"$firstMessage"

Return ONLY the title, no explanation or quotes.
''';

      // Use the _defaultModel for this general task
      final response = await _defaultModel.generateContent([
        Content.text(prompt),
      ]);

      return response.text?.trim() ?? _fallbackTitle(firstMessage);
    } catch (e) {
      // Fallback to truncated first message on error
      return _fallbackTitle(firstMessage);
    }
  }

  /// Helper for creating a fallback title
  String _fallbackTitle(String message) {
    return message.length > 40 ? '${message.substring(0, 40)}...' : message;
  }

  /// Clear current chat session
  void clearSession() {
    _chatSession = null;
  }
}

/// Custom exception for AI errors
class AIException implements Exception {
  final String message;
  AIException(this.message);

  @override
  String toString() => message;
}

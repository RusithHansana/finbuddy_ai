import 'package:finbuddy_ai/models/app_user.dart';

/// Application-wide constants and configuration values
class AppConstants {
  // App Info
  static const String appName = 'FinBuddy';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your friendly financial advisor';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String conversationsCollection = 'conversations';
  static const String messagesCollection = 'messages';

  // AI Configuration
  static const String geminiModel = 'gemini-2.5-flash';
  static const int maxContextMessages = 10;
  static const int maxMessageLength = 500;
  static const double aiTemperature = 0.7;
  static const int topK = 40;
  static const double topP = 0.95;
  static const int aiMaxOutputTokens = 1024;

  // Local Storage Keys
  static const String userIncomeKey = 'user_income';
  static const String cacheBoxName = 'cache';
  static const String themeKey = 'theme_mode';

  // UI Constants
  static const int messagesPerPage = 50;
  static const Duration typingIndicatorDelay = Duration(milliseconds: 500);
  static const Duration messageAnimationDuration = Duration(milliseconds: 200);

  // Routes
  static const String welcomeRoute = '/';
  static const String signInRoute = '/sign-in';
  static const String signUpRoute = '/sign-up';
  static const String chatRoute = '/chat';
  static const String historyRoute = '/history';
  static const String settingsRoute = '/settings';
  static const String profileEditRoute = '/settings/profile-edit';
}

/// System prompts for AI
class AIPrompts {
  static const String systemPrompt = '''
You are FinBuddy, a friendly and knowledgeable personal finance advisor.

Your role:
- Help users make informed financial decisions
- Provide practical, actionable budgeting advice
- Be encouraging and non-judgmental
- Keep responses concise (2-3 paragraphs max)
- Avoid complex financial jargon
- Reference user's income and goals when relevant

Remember: You're a helpful friend, not a stern accountant.
''';

  static String getUserContextPrompt(AppUser? user) {
    if (user == null) return '';

    final contextParts = [];

    if (user.annualIncome != null) {
      contextParts.add(
        'User has an annual income of approximately \$${user.annualIncome!.toStringAsFixed(0)}',
      );
    }

    if (user.financialGoals.isNotEmpty) {
      contextParts.add(
        'User\'s financial goals: ${user.financialGoals.join(", ")}',
      );
    }

    if (user.context.isNotEmpty) {
      contextParts.add('Additional context: ${user.context}');
    }

    return contextParts.isEmpty
        ? ''
        : '\n\nUser Context:\n${contextParts.join('\n')}';
  }
}

/// User-facing strings for the application
class AppStrings {
  // Screen Titles
  static const String chatScreenTitle = 'FinBuddy Chat';
  static const String historyScreenTitle = 'History';
  static const String settingsScreenTitle = 'Settings';
  static const String welcomeScreenTitle = 'FinBuddy AI';
  static const String signInScreenTitle = 'Welcome Back';
  static const String signUpScreenTitle = 'Create Account';

  // Welcome Screen
  static const String welcomeMessage = 'Welcome to FinBuddy!';
  static const String welcomeSubtitle = 'Your intelligent financial companion';
  static const String personalFinancialAssistant =
      'Your personal AI financial assistant.\nAsk me anything about budgeting, saving, or financial planning!';

  // Authentication
  static const String continueWithGoogle = 'Continue with Google';
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String orDivider = 'OR';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String agreeToTerms =
      'I agree to the Terms of Service and Privacy Policy';

  // Chat
  static const String chatInputHint = 'Ask me anything about your finances...';
  static const String suggestionBudget = 'Help me create a budget';
  static const String suggestionSaving = 'Tips for saving money';
  static const String suggestionExpenses = 'Track my expenses';

  // Dialog Messages
  static const String deleteConversationTitle = 'Delete Conversation';
  static const String deleteConversationMessage =
      'Are you sure you want to delete this conversation? This action cannot be undone.';
  static const String deleteAllConversationsTitle = 'Delete All Conversations';
  static const String logoutTitle = 'Logout';
  static const String logoutMessage = 'Are you sure you want to logout?';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String confirm = 'Confirm';

  // Success Messages
  static const String conversationDeleted = 'Conversation deleted';
  static const String allConversationsDeleted = 'All conversations deleted';

  // Error Messages
  static const String failedToSend = 'Failed to send';

  // Empty States
  static const String noConversationsTitle = 'No Conversations Yet';
  static const String noConversationsMessage =
      'Start a conversation with FinBuddy to get personalized financial advice!';
  static const String noSearchResultsTitle = 'No Results Found';
  static const String noSearchResultsMessage =
      'Try adjusting your search terms or browse all conversations.';
  static const String startNewChat = 'Start New Chat';

  // Loading Messages
  static const String loading = 'Loading...';
  static const String signingIn = 'Signing in...';
  static const String signingUp = 'Signing up...';

  // Sort Options
  static const String sortBy = 'Sort By';
  static const String newestFirst = 'Newest First';
  static const String oldestFirst = 'Oldest First';
  static const String mostMessages = 'Most Messages';
  static const String alphabetical = 'A-Z';

  // Stats
  static const String conversations = 'Conversations';
  static const String totalMessages = 'Total Messages';

  // Actions
  static const String tryAgain = 'Try Again';
  static const String retry = 'Retry';
}

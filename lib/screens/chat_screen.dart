import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbuddy_ai/models/message.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/providers/chat_provider.dart';
import 'package:finbuddy_ai/widgets/app_drawer.dart';
import 'package:finbuddy_ai/widgets/chat_input.dart';
import 'package:finbuddy_ai/widgets/error_view.dart';
import 'package:finbuddy_ai/widgets/loading_indicator.dart';
import 'package:finbuddy_ai/widgets/message_bubble.dart';
import 'package:finbuddy_ai/widgets/typing_indicator.dart';
import 'package:finbuddy_ai/utils/constants.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String? conversationId;

  const ChatScreen({super.key, this.conversationId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAiTyping = false;

  @override
  void initState() {
    super.initState();
    // Set the conversation ID from the widget parameter when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.conversationId != null) {
        ref
            .read(currentConversationIdProvider.notifier)
            .setConversation(widget.conversationId);
      } else {
        ref.read(currentConversationIdProvider.notifier).clearConversation();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Future<void> _handleSendMessage(String text) async {
    if (!mounted) return; // Early exit if widget disposed

    final userAsync = ref.read(currentUserProvider);
    final user = userAsync.value;
    if (user == null) return;

    final conversationId = ref.read(currentConversationIdProvider);
    final chatActions = ref.read(chatActionsProvider.notifier);

    setState(() => _isAiTyping = true);
    _scrollToBottom();

    try {
      await chatActions.sendMessage(
        text: text,
        userId: user.uid,
        conversationId: conversationId,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to send: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isAiTyping = false);
        _scrollToBottom();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);
    final conversationId = ref.watch(currentConversationIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.chatScreenTitle)),
      drawer: const AppDrawer(),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const ErrorView(message: 'User not authenticated');
          }

          if (conversationId == null) {
            return _EmptyChat(onSendMessage: _handleSendMessage);
          }

          return _ChatContent(
            userId: user.uid,
            conversationId: conversationId,
            scrollController: _scrollController,
            isAiTyping: _isAiTyping,
            onSendMessage: _handleSendMessage,
          );
        },
        loading: () => const LoadingIndicator(),
        error: (error, stack) =>
            ErrorView(message: 'Error loading user: ${error.toString()}'),
      ),
    );
  }
}

class _ChatContent extends ConsumerWidget {
  final String userId;
  final String conversationId;
  final ScrollController scrollController;
  final bool isAiTyping;
  final Function(String) onSendMessage;

  const _ChatContent({
    required this.userId,
    required this.conversationId,
    required this.scrollController,
    required this.isAiTyping,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesStream = ref.watch(
      conversationMessagesProvider(userId, conversationId),
    );

    return Column(
      children: [
        Expanded(
          child: messagesStream.when(
            data: (messages) {
              if (messages.isEmpty) {
                return Center(
                  child: Text(
                    'Start chatting with FinBuddy!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                );
              }

              final messageList = messages.cast<Message>();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });

              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: messageList.length + (isAiTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == messageList.length && isAiTyping) {
                    return const TypingIndicator();
                  }

                  final message = messageList[index];
                  return MessageBubble(message: message);
                },
              );
            },
            loading: () => const LoadingIndicator(),
            error: (error, stack) => ErrorView(
              message: 'Error loading messages: ${error.toString()}',
            ),
          ),
        ),
        ChatInput(onSendMessage: onSendMessage, isLoading: isAiTyping),
      ],
    );
  }
}

class _EmptyChat extends StatelessWidget {
  final Function(String) onSendMessage;

  const _EmptyChat({required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 80,
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppStrings.welcomeMessage,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.personalFinancialAssistant,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _SuggestionChip(
                        label: AppStrings.suggestionBudget,
                        onTap: onSendMessage,
                      ),
                      _SuggestionChip(
                        label: AppStrings.suggestionSaving,
                        onTap: onSendMessage,
                      ),
                      _SuggestionChip(
                        label: AppStrings.suggestionExpenses,
                        onTap: onSendMessage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ChatInput(onSendMessage: onSendMessage, isLoading: false),
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final Function(String) onTap;

  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      label: Text(label),
      onPressed: () => onTap(label),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      side: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
    );
  }
}

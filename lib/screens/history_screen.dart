import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbuddy_ai/models/conversation.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/providers/history_provider.dart';
import 'package:finbuddy_ai/utils/extensions.dart';
import 'package:finbuddy_ai/widgets/app_drawer.dart';
import 'package:finbuddy_ai/widgets/conversation_item.dart';
import 'package:finbuddy_ai/widgets/conversation_stats.dart';
import 'package:finbuddy_ai/widgets/empty_state.dart';
import 'package:finbuddy_ai/widgets/error_view.dart';
import 'package:finbuddy_ai/widgets/loading_indicator.dart';
import 'package:finbuddy_ai/widgets/search_bar_widget.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
    });
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).clearQuery();
  }

  void _onSearchChanged(String query) {
    ref.read(searchQueryProvider.notifier).updateQuery(query);
  }

  Future<void> _deleteConversation(String userId, String conversationId) async {
    await ref
        .read(historyActionsProvider.notifier)
        .deleteConversation(userId: userId, conversationId: conversationId);

    if (mounted) {
      context.showSuccess('Conversation deleted');
    }
  }

  Future<void> _showDeleteAllDialog(
    String userId,
    List<Conversation> conversations,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete All Conversations'),
            content: Text(
              'Are you sure you want to delete all ${conversations.length} conversations? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Delete All'),
              ),
            ],
          ),
    );

    if (confirmed == true && mounted) {
      final conversationIds = conversations.map((c) => c.id).toList();
      await ref
          .read(historyActionsProvider.notifier)
          .deleteMultipleConversations(
            userId: userId,
            conversationIds: conversationIds,
          );

      if (mounted) {
        context.showSuccess('All conversations deleted');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? SearchBarWidget(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  hintText: 'Search conversations...',
                )
                : const Text('Chat History'),
        leading:
            _isSearching
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _stopSearch,
                )
                : null,
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _startSearch,
              tooltip: 'Search',
            ),
          userAsync.when(
            data: (user) {
              if (user == null) return const SizedBox.shrink();

              return ref
                  .watch(userConversationsProvider(user.uid))
                  .when(
                    data: (conversations) {
                      if (conversations.isEmpty) return const SizedBox.shrink();

                      return PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'delete_all') {
                            _showDeleteAllDialog(
                              user.uid,
                              conversations.cast<Conversation>(),
                            );
                          }
                        },
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 'delete_all',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete_sweep, size: 20),
                                    SizedBox(width: 12),
                                    Text('Delete All'),
                                  ],
                                ),
                              ),
                            ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const EmptyState(
              icon: Icons.person_off_outlined,
              title: 'Not Signed In',
              message: 'Please sign in to view your chat history.',
            );
          }

          return _buildConversationsList(user.uid);
        },
        loading: () => const LoadingIndicator(message: 'Loading...'),
        error:
            (error, _) => ErrorView(
              message: error.toString(),
              title: 'Error Loading User',
            ),
      ),
      floatingActionButton: userAsync.maybeWhen(
        data:
            (user) =>
                user != null
                    ? FloatingActionButton.extended(
                      onPressed: () => context.goToChat(),
                      icon: const Icon(Icons.add),
                      label: const Text('New Chat'),
                    )
                    : null,
        orElse: () => null,
      ),
    );
  }

  Widget _buildConversationsList(String userId) {
    final searchQuery = ref.watch(searchQueryProvider);

    if (searchQuery.isNotEmpty) {
      return _buildSearchResults(userId);
    }

    return ref
        .watch(userConversationsProvider(userId))
        .when(
          data: (conversations) {
            if (conversations.isEmpty) {
              return const EmptyState(
                icon: Icons.chat_bubble_outline,
                title: 'No Conversations Yet',
                message: 'Start a new chat to begin your FinBuddy journey!',
              );
            }

            return _buildConversationsListView(
              userId,
              conversations.cast<Conversation>(),
            );
          },
          loading:
              () => const LoadingIndicator(message: 'Loading conversations...'),
          error:
              (error, stackTrace) => ErrorView(
                title: 'Error Loading Conversations',
                message: error.toString(),
                onRetry:
                    () => ref.invalidate(userConversationsProvider(userId)),
              ),
        );
  }

  Widget _buildSearchResults(String userId) {
    return ref
        .watch(filteredConversationsProvider(userId))
        .when(
          data: (conversations) {
            if (conversations.isEmpty) {
              return const EmptyState(
                icon: Icons.search_off,
                title: 'No Results Found',
                message: 'Try adjusting your search query.',
              );
            }

            return _buildConversationsListView(
              userId,
              conversations.cast<Conversation>(),
            );
          },
          loading: () => const LoadingIndicator(message: 'Searching...'),
          error:
              (error, stackTrace) => ErrorView(
                title: 'Search Error',
                message: error.toString(),
                onRetry:
                    () => ref.invalidate(filteredConversationsProvider(userId)),
              ),
        );
  }

  Widget _buildConversationsListView(
    String userId,
    List<Conversation> conversations,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(userConversationsProvider(userId));
      },
      child: Column(
        children: [
          // Statistics widget
          ConversationStats(conversations: conversations),
          // Conversations list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: conversations.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationItem(
                  conversation: conversation,
                  onTap:
                      () => context.goToChat(conversationId: conversation.id),
                  onDelete: () => _deleteConversation(userId, conversation.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

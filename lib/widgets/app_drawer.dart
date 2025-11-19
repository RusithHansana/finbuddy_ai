import 'package:finbuddy_ai/models/conversation.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/providers/history_provider.dart';
import 'package:finbuddy_ai/providers/router_provider.dart';
import 'package:finbuddy_ai/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: theme.colorScheme.surface,
                      child: userAsync.when(
                        data: (user) {
                          if (user?.photoUrl != null) {
                            return ClipOval(
                              child: Image.network(
                                user!.photoUrl!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.person,
                                    size: 28,
                                    color: theme.colorScheme.primary,
                                  );
                                },
                              ),
                            );
                          }
                          return Icon(
                            Icons.person,
                            size: 28,
                            color: theme.colorScheme.primary,
                          );
                        },
                        loading: () => Icon(
                          Icons.person,
                          size: 28,
                          color: theme.colorScheme.primary,
                        ),
                        error: (_, __) => Icon(
                          Icons.person,
                          size: 28,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: userAsync.when(
                        data: (user) => Text(
                          'Welcome back, ${user?.displayName ?? 'Guest'}!',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        loading: () => Text(
                          'Loading...',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        error: (_, __) => Text(
                          'Welcome back, Guest!',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _DrawerItem(
                  icon: Icons.chat_outlined,
                  title: 'New Chat',
                  route: Routes.chat,
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  route: Routes.settings,
                ),
                const Divider(),
                // Recent Chats Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Chats',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.go(Routes.history);
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
                _buildRecentChats(context, ref, userAsync),
                const Divider(),
              ],
            ),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  // Show confirmation dialog
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            try {
                              await ref
                                  .read(authActionsProvider.notifier)
                                  .signOut();
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to logout: $e'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout == true && context.mounted) {
                    await ref.read(authActionsProvider.notifier).signOut();
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.error,
                  side: BorderSide(color: theme.colorScheme.error),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentChats(
    BuildContext context,
    WidgetRef ref,
    AsyncValue userAsync,
  ) {
    return userAsync.when(
      data: (user) {
        if (user == null) {
          return const SizedBox.shrink();
        }

        return ref
            .watch(userConversationsProvider(user.uid))
            .when(
              data: (conversations) {
                if (conversations.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'No conversations yet',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(153),
                        ),
                      ),
                    ),
                  );
                }

                // Get the 5 most recent conversations
                final recentConversations = conversations
                    .cast<Conversation>()
                    .take(5)
                    .toList();

                return Column(
                  children: recentConversations.map((conversation) {
                    return _RecentChatItem(
                      conversation: conversation,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.goToChat(conversationId: conversation.id);
                      },
                    );
                  }).toList(),
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'Error loading chats',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final isSelected = currentLocation == route;
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: isSelected ? theme.colorScheme.primary : null),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.colorScheme.primary : null,
        ),
      ),
      selected: isSelected,
      selectedTileColor: theme.colorScheme.primaryContainer.withAlpha(90),
      onTap: () {
        // Close drawer
        Navigator.of(context).pop();
        // Navigate to route
        context.go(route);
      },
    );
  }
}

class _RecentChatItem extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const _RecentChatItem({required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, h:mm a');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.chat_bubble_outline,
          size: 20,
          color: theme.colorScheme.primary,
        ),
      ),
      title: Text(
        conversation.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        dateFormat.format(conversation.updatedAt),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(153),
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

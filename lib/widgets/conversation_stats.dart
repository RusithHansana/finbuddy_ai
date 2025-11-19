import 'package:flutter/material.dart';
import 'package:finbuddy_ai/models/conversation.dart';

/// A widget to display conversation statistics
class ConversationStats extends StatelessWidget {
  final List<Conversation> conversations;

  const ConversationStats({super.key, required this.conversations});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalMessages = conversations.fold<int>(
      0,
      (sum, conv) => sum + (conv.messageCount ?? 0),
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            icon: Icons.chat_bubble_outline,
            label: 'Conversations',
            value: conversations.length.toString(),
          ),
          Container(
            height: 40,
            width: 1,
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
          ),
          _buildStatItem(
            context,
            icon: Icons.message_outlined,
            label: 'Total Messages',
            value: totalMessages.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

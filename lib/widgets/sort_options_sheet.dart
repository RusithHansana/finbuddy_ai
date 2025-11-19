import 'package:flutter/material.dart';
import 'package:finbuddy_ai/utils/constants.dart';
import 'package:finbuddy_ai/utils/app_theme.dart';

/// Sort options for conversations
enum ConversationSortOption {
  newest('Newest First', Icons.arrow_downward),
  oldest('Oldest First', Icons.arrow_upward),
  mostMessages('Most Messages', Icons.message),
  alphabetical('A-Z', Icons.sort_by_alpha);

  final String label;
  final IconData icon;

  const ConversationSortOption(this.label, this.icon);
}

/// A widget to display sort options for conversations
class SortOptionsSheet extends StatelessWidget {
  final ConversationSortOption currentSort;
  final ValueChanged<ConversationSortOption> onSortChanged;

  const SortOptionsSheet({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceLg,
              vertical: AppTheme.spaceSm,
            ),
            child: Text(
              AppStrings.sortBy,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ...ConversationSortOption.values.map((option) {
            final isSelected = option == currentSort;
            return ListTile(
              leading: Icon(
                option.icon,
                color: isSelected ? theme.colorScheme.primary : null,
              ),
              title: Text(
                option.label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.colorScheme.primary : null,
                ),
              ),
              trailing:
                  isSelected
                      ? Icon(Icons.check, color: theme.colorScheme.primary)
                      : null,
              onTap: () {
                onSortChanged(option);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }

  /// Show the sort options bottom sheet
  static Future<void> show(
    BuildContext context, {
    required ConversationSortOption currentSort,
    required ValueChanged<ConversationSortOption> onSortChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.spaceMd),
        ),
      ),
      builder:
          (context) => SortOptionsSheet(
            currentSort: currentSort,
            onSortChanged: onSortChanged,
          ),
    );
  }
}

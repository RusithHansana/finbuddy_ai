import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/utils/constants.dart';

/// A logout button widget that signs out the current user
class LogoutButton extends ConsumerWidget {
  final bool isIconButton;
  final String? text;
  final Color? color;
  final Color? iconColor;

  const LogoutButton({
    super.key,
    this.isIconButton = true,
    this.text,
    this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    void handleLogout() async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(AppStrings.logoutTitle),
          content: const Text(AppStrings.logoutMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        ),
      );

      if (shouldLogout == true && context.mounted) {
        try {
          await ref.read(authActionsProvider.notifier).signOut();
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to logout: $e'),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        }
      }
    }

    if (isIconButton) {
      return IconButton(
        onPressed: handleLogout,
        icon: Icon(
          Icons.logout,
          color: iconColor ?? theme.colorScheme.onSurface,
        ),
        tooltip: 'Logout',
      );
    }

    return ElevatedButton.icon(
      onPressed: handleLogout,
      icon: const Icon(Icons.logout),
      label: Text(text ?? 'Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? theme.colorScheme.error,
        foregroundColor: theme.colorScheme.onError,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

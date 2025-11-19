import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/providers/settings_provider.dart';
import 'package:finbuddy_ai/widgets/app_drawer.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), elevation: 0),
      drawer: const AppDrawer(),
      body: currentUserAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $error',
                    style: TextStyle(color: colorScheme.error),
                  ),
                ],
              ),
            ),
        data:
            (user) =>
                user == null
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_off_outlined,
                            size: 64,
                            color: colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No user logged in',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        // User Info Section
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            'Account',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          elevation: 0,
                          color: colorScheme.surfaceContainerHighest,
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: colorScheme.primaryContainer,
                                  child: Icon(
                                    Icons.person,
                                    color: colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                title: Text(
                                  user.displayName ?? 'No name',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Username',
                                  style: theme.textTheme.bodySmall,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              Divider(height: 1, indent: 72, endIndent: 16),
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      colorScheme.secondaryContainer,
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                                ),
                                title: Text(
                                  user.email,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Email',
                                  style: theme.textTheme.bodySmall,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Preferences Section
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                          child: Text(
                            'Preferences',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          elevation: 0,
                          color: colorScheme.surfaceContainerHighest,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: colorScheme.tertiaryContainer,
                              child: Icon(
                                Icons.brightness_6,
                                color: colorScheme.onTertiaryContainer,
                              ),
                            ),
                            title: Text(
                              'Theme',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'Customize app appearance',
                              style: theme.textTheme.bodySmall,
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: colorScheme.outline.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),
                              child: DropdownButton<ThemeMode>(
                                value: themeMode,
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(8),
                                onChanged: (ThemeMode? newMode) {
                                  if (newMode != null) {
                                    ref
                                        .read(themeModeProvider.notifier)
                                        .setThemeMode(newMode);
                                  }
                                },
                                items: const [
                                  DropdownMenuItem(
                                    value: ThemeMode.system,
                                    child: Text('System'),
                                  ),
                                  DropdownMenuItem(
                                    value: ThemeMode.light,
                                    child: Text('Light'),
                                  ),
                                  DropdownMenuItem(
                                    value: ThemeMode.dark,
                                    child: Text('Dark'),
                                  ),
                                ],
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                        ),

                        // Logout Section
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                          child: Text(
                            'Actions',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          elevation: 0,
                          color: colorScheme.errorContainer.withValues(
                            alpha: 0.3,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: colorScheme.errorContainer,
                              child: Icon(
                                Icons.logout_rounded,
                                color: colorScheme.error,
                              ),
                            ),
                            title: Text(
                              'Logout',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'Sign out of your account',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.error.withValues(alpha: 0.7),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: colorScheme.error,
                              size: 16,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      icon: Icon(
                                        Icons.logout_rounded,
                                        color: colorScheme.error,
                                        size: 32,
                                      ),
                                      title: const Text('Logout'),
                                      content: const Text(
                                        'Are you sure you want to logout?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(context).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: colorScheme.error,
                                            foregroundColor:
                                                colorScheme.onError,
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            try {
                                              await ref
                                                  .read(
                                                    authActionsProvider
                                                        .notifier,
                                                  )
                                                  .signOut();
                                            } catch (e) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Failed to logout: $e',
                                                    ),
                                                    backgroundColor:
                                                        colorScheme.error,
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
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
      ),
    );
  }
}

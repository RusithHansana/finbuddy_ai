import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finbuddy_ai/widgets/custom_button.dart';
import 'package:finbuddy_ai/widgets/google_sign_in_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finbuddy_ai/providers/auth_provider.dart';
import 'package:finbuddy_ai/utils/constants.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _isGoogleSignInLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isGoogleSignInLoading = true;
    });

    try {
      await ref.read(authActionsProvider.notifier).signInWithGoogle();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in failed: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleSignInLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const SizedBox(height: 24),
              // App Title
              Text(
                AppStrings.welcomeScreenTitle,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // App Description
              Text(
                AppStrings.welcomeSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Google Sign In Button
              GoogleSignInButton(
                onPressed: _handleGoogleSignIn,
                isLoading: _isGoogleSignInLoading,
              ),
              const SizedBox(height: 16),
              // Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: theme.colorScheme.outlineVariant),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppStrings.orDivider,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: theme.colorScheme.outlineVariant),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Sign In Button
              CustomButton(
                text: AppStrings.signIn,
                onPressed: () => context.go('/sign-in'),
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              // Sign Up Button
              CustomButton(
                text: AppStrings.signUp,
                onPressed: () => context.go('/sign-up'),
                isOutlined: true,
                width: double.infinity,
              ),
              const Spacer(),
              // Terms and Privacy
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

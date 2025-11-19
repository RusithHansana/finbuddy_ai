import 'package:flutter/material.dart';
import 'package:finbuddy_ai/utils/constants.dart';
import 'package:finbuddy_ai/utils/app_theme.dart';

/// Google Sign In button with proper branding
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoogleSignInButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceMd),
          side: BorderSide(color: theme.colorScheme.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/google_logo.png',
                    height: 24,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to icon if image not found
                      return const Icon(
                        Icons.g_mobiledata,
                        size: 24,
                        color: Colors.red,
                      );
                    },
                  ),
                  const SizedBox(width: AppTheme.spaceMd),
                  Text(
                    AppStrings.continueWithGoogle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

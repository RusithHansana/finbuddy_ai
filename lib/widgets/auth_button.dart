import 'package:flutter/material.dart';
import 'package:finbuddy_ai/widgets/custom_button.dart';

/// Specialized button for authentication actions
class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isOutlined: isSecondary,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}

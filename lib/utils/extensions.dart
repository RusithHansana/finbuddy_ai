import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Navigate to chat screen
  void goToChat({String? conversationId}) {
    if (conversationId != null) {
      go('${AppConstants.chatRoute}?conversationId=$conversationId');
    } else {
      go(AppConstants.chatRoute);
    }
  }

  /// Navigate to history screen
  void goToHistory() => go(AppConstants.historyRoute);

  /// Navigate to settings screen
  void goToSettings() => go(AppConstants.settingsRoute);

  /// Navigate back
  void goBack() => pop();

  /// Show error snackbar
  void showError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show success snackbar
  void showSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show loading dialog
  void showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    Navigator.of(this).pop();
  }

  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  // MediaQuery shortcuts
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
}

/// Extension methods for String
extension StringExtensions on String {
  /// Capitalizes first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Checks if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}

/// Extension methods for DateTime
extension DateTimeExtensions on DateTime {
  /// Checks if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}

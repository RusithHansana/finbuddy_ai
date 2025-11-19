import 'package:finbuddy_ai/utils/constants.dart';

/// Input validation utilities
class Validators {
  /// Validates email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validates password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validates confirm password matches password
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates display name
  static String? validateDisplayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }

    return null;
  }

  /// Validates income amount
  static String? validateIncome(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Income is optional
    }

    final income = double.tryParse(value);
    if (income == null) {
      return 'Please enter a valid number';
    }

    if (income < 0) {
      return 'Income cannot be negative';
    }

    if (income > 10000000) {
      return 'Please enter a realistic income';
    }

    return null;
  }

  /// Validates message text
  static String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Message cannot be empty';
    }

    if (value.length > AppConstants.maxMessageLength) {
      return 'Message is too long (max ${AppConstants.maxMessageLength} characters)';
    }

    return null;
  }
}

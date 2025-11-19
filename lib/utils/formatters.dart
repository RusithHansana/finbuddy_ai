import 'package:intl/intl.dart';

/// Formatting utilities for display purposes
class Formatters {
  /// Formats currency amounts
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 0);
    return formatter.format(amount);
  }

  /// Formats currency with decimals
  static String formatCurrencyDetailed(double amount, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  /// Formats timestamps for chat messages
  static String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // Today - show time only
      return DateFormat.jm().format(dateTime); // 2:30 PM
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat.EEEE().format(dateTime); // Monday
    } else {
      return DateFormat.MMMd().format(dateTime); // Jan 15
    }
  }

  /// Formats full date and time
  static String formatFullDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy • h:mm a').format(dateTime);
  }

  /// Formats relative time (e.g., "5 minutes ago")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat.MMMd().format(dateTime);
    }
  }

  /// Truncates text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Formats conversation title from first message
  static String generateConversationTitle(String firstMessage) {
    final cleaned = firstMessage.trim();
    return truncateText(cleaned, 50);
  }
}

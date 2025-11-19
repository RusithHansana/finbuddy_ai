import 'package:flutter/material.dart';

/// FinBuddy's custom Material Design 3 theme
/// Follows latest M3 guidelines with ColorScheme.fromSeed
class AppTheme {
  // ============== SPACING SYSTEM (8dp Grid) ==============

  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;

  // ============== BORDER RADIUS ==============

  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 9999.0;

  // ============== ELEVATION ==============

  static const double elevation0 = 0.0;
  static const double elevation1 = 2.0;
  static const double elevation2 = 4.0;
  static const double elevation3 = 8.0;
  static const double elevation4 = 12.0;
  static const double elevation5 = 16.0;

  // ============== BRAND COLORS ==============

  // Primary: Trustworthy purple/blue - financial confidence
  static const Color primarySeedColor = Color(0xFF226CE0);

  // Secondary: Success green - positive financial outcomes
  static const Color secondarySeedColor = Color(0xFF00D4AA);

  // Tertiary: Accent pink - important highlights
  static const Color tertiarySeedColor = Color(0xFFFF6B9D);

  // ============== LIGHT THEME ==============

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primarySeedColor,
      brightness: Brightness.light,
      // Override specific colors for brand consistency
      secondary: secondarySeedColor,
      tertiary: tertiarySeedColor,
      error: const Color(0xFFDC2626),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // ============== TYPOGRAPHY ==============
      textTheme: _textTheme(colorScheme),

      // ============== APP BAR THEME ==============
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: elevation1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
      ),

      // ============== CARD THEME ==============
      cardTheme: CardThemeData(
        elevation: elevation1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(spaceSm),
      ),

      // ============== INPUT DECORATION THEME ==============
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16),
        labelStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
      ),

      // ============== ELEVATED BUTTON THEME ==============
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: elevation1,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.surfaceContainerHighest,
          disabledForegroundColor: colorScheme.onSurfaceVariant,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(64, 48),
        ),
      ),

      // ============== OUTLINED BUTTON THEME ==============
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline, width: 1),
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(64, 48),
        ),
      ),

      // ============== TEXT BUTTON THEME ==============
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // ============== FLOATING ACTION BUTTON THEME ==============
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: elevation3,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),

      // ============== BOTTOM NAVIGATION BAR THEME ==============
      navigationBarTheme: NavigationBarThemeData(
        elevation: elevation2,
        height: 80,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colorScheme.onPrimaryContainer,
              size: 24,
            );
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant, size: 24);
        }),
      ),

      // ============== DIALOG THEME ==============
      dialogTheme: DialogThemeData(
        elevation: elevation5,
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // ============== SNACKBAR THEME ==============
      snackBarTheme: SnackBarThemeData(
        elevation: elevation3,
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          fontSize: 14,
          color: colorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
      ),

      // ============== CHIP THEME ==============
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurfaceVariant,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        elevation: 0,
      ),

      // ============== DIVIDER THEME ==============
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: spaceMd,
      ),

      // ============== LIST TILE THEME ==============
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        tileColor: Colors.transparent,
        selectedTileColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
      ),

      // ============== ICON THEME ==============
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant, size: 24),

      primaryIconTheme: IconThemeData(color: colorScheme.primary, size: 24),
    );
  }

  // ============== DARK THEME ==============

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primarySeedColor,
      brightness: Brightness.dark,
      // Override specific colors for brand consistency
      secondary: secondarySeedColor,
      tertiary: tertiarySeedColor,
      error: const Color(0xFFEF4444),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // ============== TYPOGRAPHY ==============
      textTheme: _textTheme(colorScheme),

      // ============== APP BAR THEME ==============
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: elevation1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
      ),

      // ============== CARD THEME ==============
      cardTheme: CardThemeData(
        elevation: elevation1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(spaceSm),
      ),

      // ============== INPUT DECORATION THEME ==============
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMd),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 16),
        labelStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
      ),

      // ============== ELEVATED BUTTON THEME ==============
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: elevation1,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.surfaceContainerHighest,
          disabledForegroundColor: colorScheme.onSurfaceVariant,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(64, 48),
        ),
      ),

      // ============== OUTLINED BUTTON THEME ==============
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline, width: 1),
          padding: const EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          minimumSize: const Size(64, 48),
        ),
      ),

      // ============== TEXT BUTTON THEME ==============
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // ============== FLOATING ACTION BUTTON THEME ==============
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: elevation3,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
      ),

      // ============== BOTTOM NAVIGATION BAR THEME ==============
      navigationBarTheme: NavigationBarThemeData(
        elevation: elevation2,
        height: 80,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            );
          }
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: colorScheme.onPrimaryContainer,
              size: 24,
            );
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant, size: 24);
        }),
      ),

      // ============== DIALOG THEME ==============
      dialogTheme: DialogThemeData(
        elevation: elevation5,
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLg),
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          color: colorScheme.onSurfaceVariant,
        ),
      ),

      // ============== SNACKBAR THEME ==============
      snackBarTheme: SnackBarThemeData(
        elevation: elevation3,
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          fontSize: 14,
          color: colorScheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
      ),

      // ============== CHIP THEME ==============
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primaryContainer,
        disabledColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        labelStyle: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurfaceVariant,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        elevation: 0,
      ),

      // ============== DIVIDER THEME ==============
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: spaceMd,
      ),

      // ============== LIST TILE THEME ==============
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceSm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        tileColor: Colors.transparent,
        selectedTileColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
      ),

      // ============== ICON THEME ==============
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant, size: 24),

      primaryIconTheme: IconThemeData(color: colorScheme.primary, size: 24),
    );
  }

  // ============== TEXT THEME ==============

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Display styles - Large headlines
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        height: 1.12,
        letterSpacing: -0.25,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        height: 1.16,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 1.22,
        color: colorScheme.onSurface,
      ),

      // Headline styles - Medium headlines
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
        color: colorScheme.onSurface,
      ),

      // Title styles - Small headlines
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.27,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.50,
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),

      // Body styles - Body text
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
        color: colorScheme.onSurfaceVariant,
      ),

      // Label styles - Labels and captions
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.33,
        letterSpacing: 0.5,
        color: colorScheme.onSurfaceVariant,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

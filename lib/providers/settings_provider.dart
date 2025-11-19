import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';

part 'settings_provider.g.dart';

// ============== STORAGE SERVICE PROVIDER ==============

@riverpod
StorageService storageService(Ref ref) {
  return StorageService();
}

// ============== THEME MODE PROVIDER ==============

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    try {
      final storage = ref.watch(storageServiceProvider);
      final savedTheme = storage.getString(AppConstants.themeKey);

      switch (savedTheme) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        default:
          return ThemeMode.system;
      }
    } catch (e) {
      // If storage is not initialized or fails, default to system
      return ThemeMode.system;
    }
  }

  Future setThemeMode(ThemeMode mode) async {
    try {
      final storage = ref.read(storageServiceProvider);

      String modeString;
      switch (mode) {
        case ThemeMode.light:
          modeString = 'light';
          break;
        case ThemeMode.dark:
          modeString = 'dark';
          break;
        case ThemeMode.system:
          modeString = 'system';
          break;
      }

      await storage.saveString(AppConstants.themeKey, modeString);
      state = mode;
    } catch (e) {
      // If storage fails, still update the state for immediate UI feedback
      state = mode;
    }
  }
}

// ============== NOTIFICATION SETTINGS PROVIDER ==============

@riverpod
class NotificationSettings extends _$NotificationSettings {
  @override
  bool build() {
    try {
      final storage = ref.watch(storageServiceProvider);
      return storage.getBool('notifications_enabled') ?? true;
    } catch (e) {
      // If storage fails, default to true
      return true;
    }
  }

  Future toggle() async {
    try {
      final storage = ref.read(storageServiceProvider);
      final newValue = !state;
      await storage.saveBool('notifications_enabled', newValue);
      state = newValue;
    } catch (e) {
      // If storage fails, still update state for immediate UI feedback
      state = !state;
    }
  }

  Future setEnabled(bool enabled) async {
    try {
      final storage = ref.read(storageServiceProvider);
      await storage.saveBool('notifications_enabled', enabled);
      state = enabled;
    } catch (e) {
      // If storage fails, still update state for immediate UI feedback
      state = enabled;
    }
  }
}

// ============== SETTINGS ACTIONS PROVIDER ==============

@riverpod
class SettingsActions extends _$SettingsActions {
  @override
  FutureOr build() {}

  /// Clear all local data
  Future clearAllData() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final storage = ref.read(storageServiceProvider);
      await storage.clearCache();
      await storage.clearPreferences();
    });
  }

  /// Clear cache only
  Future clearCache() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final storage = ref.read(storageServiceProvider);
      await storage.clearCache();
    });
  }

  /// Export user data (placeholder for future implementation)
  Future exportUserData() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      throw UnimplementedError('Data export not yet implemented');
    });
  }
}

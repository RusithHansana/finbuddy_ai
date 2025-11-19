import 'package:finbuddy_ai/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local storage service using Hive and SharedPreferences
/// Handles offline caching and user preferences
class StorageService {
  static late Box _cacheBox;
  static SharedPreferences? _prefs;

  /// Initialize storage
  static Future initialize() async {
    await Hive.initFlutter();
    _cacheBox = await Hive.openBox(AppConstants.cacheBoxName);
    _prefs = await SharedPreferences.getInstance();
  }

  // ============== CACHE OPERATIONS (Hive) ==============

  /// Save data to cache
  Future saveToCache(String key, dynamic value) async {
    try {
      await _cacheBox.put(key, value);
    } catch (e) {
      throw StorageException('Failed to save to cache: ${e.toString()}');
    }
  }

  /// Get data from cache
  dynamic getFromCache(String key) {
    try {
      return _cacheBox.get(key);
    } catch (e) {
      throw StorageException('Failed to get from cache: ${e.toString()}');
    }
  }

  /// Check if key exists in cache
  bool existsInCache(String key) {
    return _cacheBox.containsKey(key);
  }

  /// Delete from cache
  Future deleteFromCache(String key) async {
    try {
      await _cacheBox.delete(key);
    } catch (e) {
      throw StorageException('Failed to delete from cache: ${e.toString()}');
    }
  }

  /// Clear all cache
  Future clearCache() async {
    try {
      await _cacheBox.clear();
    } catch (e) {
      throw StorageException('Failed to clear cache: ${e.toString()}');
    }
  }

  // ============== PREFERENCES OPERATIONS (SharedPreferences) ==============

  /// Save string preference
  Future saveString(String key, String value) async {
    try {
      if (_prefs == null) {
        throw StorageException('StorageService not initialized');
      }
      await _prefs!.setString(key, value);
    } catch (e) {
      throw StorageException(
        'Failed to save string preference: ${e.toString()}',
      );
    }
  }

  /// Get string preference
  String? getString(String key) {
    if (_prefs == null) {
      throw StorageException('StorageService not initialized');
    }
    return _prefs!.getString(key);
  }

  /// Save boolean preference
  Future saveBool(String key, bool value) async {
    try {
      if (_prefs == null) {
        throw StorageException('StorageService not initialized');
      }
      await _prefs!.setBool(key, value);
    } catch (e) {
      throw StorageException(
        'Failed to save boolean preference: ${e.toString()}',
      );
    }
  }

  /// Get boolean preference
  bool? getBool(String key) {
    if (_prefs == null) {
      throw StorageException('StorageService not initialized');
    }
    return _prefs!.getBool(key);
  }

  /// Save int preference
  Future saveInt(String key, int value) async {
    try {
      if (_prefs == null) {
        throw StorageException('StorageService not initialized');
      }
      await _prefs!.setInt(key, value);
    } catch (e) {
      throw StorageException('Failed to save int preference: ${e.toString()}');
    }
  }

  /// Get int preference
  int? getInt(String key) {
    if (_prefs == null) {
      throw StorageException('StorageService not initialized');
    }
    return _prefs!.getInt(key);
  }

  /// Save double preference
  Future saveDouble(String key, double value) async {
    try {
      if (_prefs == null) {
        throw StorageException('StorageService not initialized');
      }
      await _prefs!.setDouble(key, value);
    } catch (e) {
      throw StorageException(
        'Failed to save double preference: ${e.toString()}',
      );
    }
  }

  /// Get double preference
  double? getDouble(String key) {
    if (_prefs == null) {
      throw StorageException('StorageService not initialized');
    }
    return _prefs!.getDouble(key);
  }

  /// Remove preference
  Future remove(String key) async {
    try {
      if (_prefs == null) {
        throw StorageException('StorageService not initialized');
      }
      await _prefs!.remove(key);
    } catch (e) {
      throw StorageException('Failed to remove preference: ${e.toString()}');
    }
  }

  /// Clear all preferences
  Future clearPreferences() async {
    try {
      if (_prefs == null) {
        throw StorageException('StorageService not initialized');
      }
      await _prefs!.clear();
    } catch (e) {
      throw StorageException('Failed to clear preferences: ${e.toString()}');
    }
  }

  /// Check if preference exists
  bool containsKey(String key) {
    if (_prefs == null) {
      throw StorageException('StorageService not initialized');
    }
    return _prefs!.containsKey(key);
  }
}

/// Custom exception for storage errors
class StorageException implements Exception {
  final String message;
  StorageException(this.message);

  @override
  String toString() => message;
}

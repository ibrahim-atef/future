import 'package:hive/hive.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';

class StorageService {
  static late Box _settingsBox;
  static late Box _userBox;
  static late Box _downloadsBox;

  static Future<void> init() async {
    _settingsBox = await Hive.openBox('settings');
    _userBox = await Hive.openBox('user');
    _downloadsBox = await Hive.openBox('downloads');
  }

  // User Token Management
  static Future<void> saveToken(String token) async {
    await _userBox.put(AppConstants.userTokenKey, token);
  }

  static String? getToken() {
    return _userBox.get(AppConstants.userTokenKey);
  }

  static Future<void> clearToken() async {
    await _userBox.delete(AppConstants.userTokenKey);
  }

  // Legacy methods for backward compatibility
  static Future<void> saveUserToken(String token) async {
    await saveToken(token);
  }

  static String? getUserToken() {
    return getToken();
  }

  static Future<void> clearUserToken() async {
    await clearToken();
  }

  // User Data Management
  static Future<void> saveUserData(UserModel user) async {
    await _userBox.put(AppConstants.userDataKey, user.toJson());
  }

  static UserModel? getUserData() {
    final userData = _userBox.get(AppConstants.userDataKey);
    if (userData != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  static Future<void> clearUserData() async {
    await _userBox.delete(AppConstants.userDataKey);
  }

  // Settings Management
  static Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _settingsBox.putAll(settings);
  }

  static T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue);
  }

  static Future<void> setSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }

  // Download Management
  static Future<void> saveDownloadInfo(String id, Map<String, dynamic> downloadInfo) async {
    await _downloadsBox.put(id, downloadInfo);
  }

  static Map<String, dynamic>? getDownloadInfo(String id) {
    final data = _downloadsBox.get(id);
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  static List<Map<String, dynamic>> getAllDownloads() {
    return _downloadsBox.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static Future<void> removeDownloadInfo(String id) async {
    await _downloadsBox.delete(id);
  }

  static Future<void> clearAllDownloads() async {
    await _downloadsBox.clear();
  }

  // App Settings
  static bool get isWifiOnly => getSetting('wifi_only', defaultValue: false) ?? false;
  static set isWifiOnly(bool value) => setSetting('wifi_only', value);

  static String get downloadQuality => getSetting('download_quality', defaultValue: 'عالية الجودة') ?? 'عالية الجودة';
  static set downloadQuality(String value) => setSetting('download_quality', value);

  static bool get notificationsEnabled => getSetting('notifications_enabled', defaultValue: true) ?? true;
  static set notificationsEnabled(bool value) => setSetting('notifications_enabled', value);

  static bool get allowProfileEdit => getSetting('allow_profile_edit', defaultValue: false) ?? false;
  static set allowProfileEdit(bool value) => setSetting('allow_profile_edit', value);

  // Clear All Data
  static Future<void> clearAllData() async {
    await _userBox.clear();
    await _settingsBox.clear();
    await _downloadsBox.clear();
  }
}



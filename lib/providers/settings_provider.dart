import 'package:flutter/material.dart';
import '../core/services/storage_service.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool _notificationsEnabled = true;
  bool _allowProfileEdit = false;
  String _language = 'ar';
  String _downloadQuality = 'عالية الجودة';
  bool _wifiOnly = false;

  bool get isDarkMode => _isDarkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get allowProfileEdit => _allowProfileEdit;
  String get language => _language;
  String get downloadQuality => _downloadQuality;
  bool get wifiOnly => _wifiOnly;

  SettingsProvider() {
    _loadSettings();
  }

  void _loadSettings() {
    _notificationsEnabled = StorageService.notificationsEnabled;
    _allowProfileEdit = StorageService.allowProfileEdit;
    _downloadQuality = StorageService.downloadQuality;
    _wifiOnly = StorageService.isWifiOnly;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    StorageService.notificationsEnabled = _notificationsEnabled;
    notifyListeners();
  }

  void setNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    StorageService.notificationsEnabled = value;
    notifyListeners();
  }

  void toggleProfileEdit() {
    _allowProfileEdit = !_allowProfileEdit;
    StorageService.allowProfileEdit = _allowProfileEdit;
    notifyListeners();
  }

  void setAllowProfileEdit(bool value) {
    _allowProfileEdit = value;
    StorageService.allowProfileEdit = value;
    notifyListeners();
  }

  void setLanguage(String language) {
    _language = language;
    notifyListeners();
  }

  void setDownloadQuality(String quality) {
    _downloadQuality = quality;
    StorageService.downloadQuality = quality;
    notifyListeners();
  }

  void setWifiOnly(bool value) {
    _wifiOnly = value;
    StorageService.isWifiOnly = value;
    notifyListeners();
  }

  void resetToDefaults() {
    _isDarkMode = true;
    _notificationsEnabled = true;
    _allowProfileEdit = false;
    _language = 'ar';
    _downloadQuality = 'عالية الجودة';
    _wifiOnly = false;

    StorageService.notificationsEnabled = _notificationsEnabled;
    StorageService.allowProfileEdit = _allowProfileEdit;
    StorageService.downloadQuality = _downloadQuality;
    StorageService.isWifiOnly = _wifiOnly;

    notifyListeners();
  }
}

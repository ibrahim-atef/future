import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  /// Get a unique device identifier
  static Future<String?> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id; // Unique ID on Android (previously androidId)
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor; // Unique ID on iOS
      }
    } catch (e) {
      print('Error getting device ID: $e');
      return null;
    }
    return null;
  }

  /// Get detailed device information
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> deviceData = {};

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceData = {
          'id': androidInfo.id,
          'model': androidInfo.model,
          'brand': androidInfo.brand,
          'device': androidInfo.device,
          'androidVersion': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceData = {
          'id': iosInfo.identifierForVendor,
          'name': iosInfo.name,
          'model': iosInfo.model,
          'systemName': iosInfo.systemName,
          'systemVersion': iosInfo.systemVersion,
        };
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    return deviceData;
  }
}

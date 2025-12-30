// Import necessary libraries
import 'dart:developer'; // For logging and debugging
import 'dart:io' show Platform; // For platform detection
import 'dart:math'
    show Random; // For generating random numbers (show only Random class)
import 'package:firebase_core/firebase_core.dart'; // Firebase core functionality
import 'package:firebase_messaging/firebase_messaging.dart'; // Firebase Cloud Messaging
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Local notifications plugin

// Main class for handling Firebase notifications
class FirebaseNotification {
  // Firebase Messaging instance for handling FCM
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Local notifications plugin for showing notifications
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Variable to store the FCM token (device registration token)
  static String? fcmToken;
  
  // Variable to store the APNS token (iOS only)
  static String apnsToken = "";

  // Android notification channel configuration (required for Android 8.0+)
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // Channel ID (must be unique)
    'High Importance Notifications', // Channel name visible to user
    description:
        'This channel is used for important notifications.', // Channel description
    importance: Importance.high, // High importance for sound and alert
  );

  // Main initialization method for notifications
  static Future<void> initializeNotifications() async {
    try {
      log('🔵 Starting notification service initialization...');
      
      await requestNotificationPermission(); // Request user permission
      
      // Get FCM token - handle errors gracefully to prevent app crash
      // Use unawaited or catch to prevent blocking
      getFcmToken().catchError((error, stackTrace) {
        log('⚠️ Error in getFcmToken during initialization: $error');
        log('⚠️ Stack trace: $stackTrace');
        log('ℹ️ Continuing app initialization without FCM token...');
        // Don't rethrow - allow app to continue
      });
      
      // Don't await getFcmToken to prevent blocking - let it run in background
      // This prevents the app from hanging if APNS token is not available
      
      await initializeLocalNotifications(); // Initialize local notifications

      // Set up background message handler (when app is closed or in background)
      try {
        FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      } catch (e) {
        log('⚠️ Error setting up background message handler: $e');
      }

      // Set up foreground message listener (when app is open)
      try {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          log('Received foreground message: ${message.messageId}'); // Log message receipt
          showBasicNotification(message); // Show local notification
        });
      } catch (e) {
        log('⚠️ Error setting up foreground message listener: $e');
      }
      
      log('✅ Notification service initialized successfully');
    } catch (e, stackTrace) {
      log('❌ Error initializing notifications: $e');
      log('❌ Stack trace: $stackTrace');
      // Don't rethrow - allow app to continue even if notifications fail
    }
  }

  // Initialize local notifications plugin
  static Future<void> initializeLocalNotifications() async {
    // Configuration for initializing local notifications
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android:
          AndroidInitializationSettings('@mipmap/ic_launcher'), // Android icon
      iOS: DarwinInitializationSettings(), // iOS settings
    );

    // Initialize the local notifications plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Create notification channel for Android (required for Android 8.0+)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Request notification permissions from user
  static Future<void> requestNotificationPermission() async {
    final NotificationSettings settings = await messaging.requestPermission();
    log('Notification permission status: ${settings.authorizationStatus}'); // Log permission status
  }

  // Get and store the FCM token for this device
  static Future<void> getFcmToken() async {
    try {
      // On iOS, we need to get the APNS token first before getting the FCM token
      if (Platform.isIOS) {
        log('🔵 [iOS] Starting APNS token retrieval...');
        
        try {
          // Request APNS token first - this is required for FCM on iOS
          String? apnsTokenValue = await messaging.getAPNSToken();
          log('🔵 [iOS] Initial APNS token request result: ${apnsTokenValue != null ? "Success" : "Null"}');
          
          // If APNS token is not immediately available, wait and retry
          if (apnsTokenValue == null) {
            log('🔵 [iOS] APNS token not immediately available, waiting 2 seconds...');
            await Future.delayed(const Duration(seconds: 2));
            
            apnsTokenValue = await messaging.getAPNSToken();
            log('🔵 [iOS] Retry APNS token request result: ${apnsTokenValue != null ? "Success" : "Null"}');
          }
          
          if (apnsTokenValue != null && apnsTokenValue.isNotEmpty) {
            apnsToken = apnsTokenValue;
            log('✅ [iOS] APNS Token retrieved successfully: ${apnsToken.substring(0, apnsToken.length > 20 ? 20 : apnsToken.length)}...');
          } else {
            // APNS token is null or empty - user may have cancelled or not granted permission
            apnsToken = "";
            log('⚠️ [iOS] APNS token is null or empty - user may have cancelled permission or token not available yet');
            log('⚠️ [iOS] Skipping FCM token request on iOS since APNS token is not available');
            log('✅ FCM token initialization completed (skipped on iOS)');
            return; // Exit early on iOS if APNS token is not available
          }
        } catch (apnsError) {
          // Handle APNS token retrieval error gracefully
          apnsToken = "";
          log('❌ [iOS] Error getting APNS token: $apnsError');
          log('⚠️ [iOS] Skipping FCM token request on iOS since APNS token failed');
          log('✅ FCM token initialization completed (skipped on iOS)');
          return; // Exit early on iOS if APNS token fails
        }
      }

      // Now get the FCM token (only for Android or if iOS has APNS token)
      log('🔵 Getting FCM token...');
      try {
        fcmToken = await messaging.getToken(); // Retrieve FCM token
        if (fcmToken != null && fcmToken!.isNotEmpty) {
          log('✅ FCM Token retrieved successfully: ${fcmToken!.substring(0, fcmToken!.length > 20 ? 20 : fcmToken!.length)}...');
        } else {
          log('⚠️ FCM Token is null or empty');
        }
      } catch (fcmError) {
        log('❌ Error getting FCM token: $fcmError');
        // Don't crash - just set to null and continue
        fcmToken = null;
      }

      // Listen for token refresh events (tokens can change) - only if we have a token
      if (fcmToken != null) {
        messaging.onTokenRefresh.listen((String newToken) {
          fcmToken = newToken; // Update stored token
          log('🔄 FCM Token refreshed: ${newToken.substring(0, newToken.length > 20 ? 20 : newToken.length)}...');
        });
      }
      
      log('✅ FCM token initialization completed');
    } catch (e, stackTrace) {
      log('❌ Unexpected error in getFcmToken: $e');
      log('❌ Stack trace: $stackTrace');
      // Continue execution even if FCM token fails - don't crash the app
      fcmToken = null;
      apnsToken = "";
    }
  }

  // Handle background messages (when app is closed or in background)
  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp(); // Initialize Firebase in background
    log('Background message received: ${message.messageId}'); // Log message receipt
    showBasicNotification(message); // Show notification
  }

  // Random number generator for unique notification IDs
  static final Random random = Random();

  // Generate a random ID for notifications (prevents duplicate IDs)
  static int generateRandomId() {
    return random.nextInt(10000); // Generate random number between 0-9999
  }

  // Display a basic local notification
  static Future<void> showBasicNotification(RemoteMessage message) async {
    try {
      // Notification details configuration for both platforms
      final NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id, // Use predefined channel ID
          channel.name, // Use predefined channel name
          channelDescription: channel.description, // Channel description
          importance: Importance.high, // High importance level
          priority: Priority.high, // High priority for notification
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true, // Show alert on iOS
          presentBadge: true, // Update app badge on iOS
          presentSound: true, // Play sound on iOS
        ),
      );

      // Display the notification using local notifications plugin
      await flutterLocalNotificationsPlugin.show(
        generateRandomId(), // Unique ID for notification
        message.notification?.title ?? 'No Title', // Title (with fallback)
        message.notification?.body ?? 'No Body', // Body (with fallback)
        details, // Platform-specific details
      );

      log('Local notification shown successfully'); // Log success
    } catch (e) {
      log('Error showing local notification: $e'); // Log any errors
    }
  }
}

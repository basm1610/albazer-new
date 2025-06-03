import 'dart:developer';
import 'package:albazar_app/Features/notificatoins/logic/cubit/notification_cubit.dart';
import 'package:albazar_app/core/di/locator.dart';
import 'package:albazar_app/core/helper/user_helper.dart';
import 'package:albazar_app/Features/notificatoins/local_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Initialize FCM - should be called after login
  static Future<void> init() async {
    await messaging.requestPermission();

    String? token = await messaging.getToken();
    if (token != null) {
      sendTokenToServer(token);
      log("FCM Token: $token");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', token);
    }

    messaging.onTokenRefresh.listen((newToken) async {
      sendTokenToServer(newToken);
      log("Refreshed FCM Token: $newToken");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', newToken);
    });

    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    _handleForegroundMessage();

    await messaging.subscribeToTopic('all');
  }

  /// Handle background messages
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    log("🔔 Background Notification Received: ${message.notification?.title}");
  }

  /// Handle foreground messages
  static void _handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("🔔 Foreground Notification: ${message.notification?.title}");
      LocalNotificationService.showBasicNotification(message);
    });
  }

  /// Send FCM token to server using NotificationCubit from locator
  static void sendTokenToServer(String token) {
    final userId = UserHelper.user?.id;
    final userToken = UserHelper.token;

    if (userId == null || userToken == null) {
      log("⚠️ User not logged in. Skipping FCM token upload.");
      return;
    }

    try {
      final cubit = locator<NotificationCubit>();
      cubit.updateNotification(
        userToken: userToken,
        fcmToken: token,
      );
    } catch (e) {
      log("❌ Failed to update FCM token via NotificationCubit: $e");
    }
  }
}

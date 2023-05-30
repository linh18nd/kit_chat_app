import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kit_chat_app/persenstation/service/local_notification.dart';
import 'package:uuid/uuid.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    await configureFirebaseMessaging();
  }

  static Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  static Future<void> configureFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        final title = notification.title ?? '';
        final content = notification.body ?? '';

        LocalNotificationService.showNotification(
          title: title,
          content: content,
          notiId: const Uuid().v1().hashCode,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        final title = notification.title ?? '';
        final content = notification.body ?? '';

        LocalNotificationService.showNotification(
          title: title,
          content: content,
          notiId: const Uuid().v1().hashCode,
        );
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    final notification = message.notification;

    if (notification != null) {
      final title = notification.title ?? '';
      final content = notification.body ?? '';

      LocalNotificationService.showNotification(
        title: title,
        content: content,
        notiId: const Uuid().v1().hashCode,
      );
    }
  }

  static Future<void> sendNotification({
    String? to,
    Map<String, String>? data,
    String? collapseKey,
    String? messageId,
    String? messageType,
    int? ttl,
  }) async {
    try {
      if (ttl != null) {
        assert(ttl >= 0);
      }

      await _firebaseMessaging.sendMessage(
        to: to ?? '@fcm.googleapis.com',
        data: data,
        collapseKey: collapseKey,
        messageId: messageId,
        messageType: messageType,
        ttl: ttl,
      );

      log('Send notification success');
    } catch (error) {
      log('Send notification error: $error');
    }
  }
}

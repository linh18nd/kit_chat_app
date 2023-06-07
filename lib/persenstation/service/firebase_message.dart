import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kit_chat_app/persenstation/service/local_notification.dart';
import 'package:http/http.dart' as http;
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
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
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
      },
    );

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

  Future<void> sendNotification({
    required String receiverToken,
    required String title,
    required String body,
  }) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAABKARwlQ:APA91bGjGBSJNYknDWDhpSJMpo7Ee_UfImx760vZ1RB9tBHh-lRy_fognPh3OOsVV4gLkmeEM0Q8u5b4gIcHtezHI2dcHyCxDQ7KO3dbTnyDrhqwShjvy-3lAMIPiYgcIgQtHONrEelk',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": receiverToken,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/service/local_notification.dart';
import 'package:http/http.dart' as http;
import 'package:kit_chat_app/route/app_route.dart';
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
        log('onBackgroundMessage: ${message.messageType}');
        if (notification != null) {
          final title = notification.title ?? '';
          final content = notification.body ?? '';
          if (message.data['type'] == 'message') {
            LocalNotificationService.showNotification(
              title: title,
              content: content,
              notiId: const Uuid().v1().hashCode,
              payload: jsonEncode(message.data),
            );
          } else if (message.data['type'] == 'call') {
            final result = message.data;
            final user = UserModel.fromJson(
              jsonDecode(result['user']),
            );
            final friend = UserModel.fromJson(
              jsonDecode(result['friend']),
            );
            final conversationId = result['conversationId'];
            if (result['type'] == 'call') {
              Get.toNamed(AppPath.call, arguments: {
                'token': conversationId,
                'user': friend,
                'friend': user,
                'isListener': true,
              });
            }
          }
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        final notification = message.notification;

        if (notification != null) {
          final title = notification.title ?? '';
          final content = notification.body ?? '';

          LocalNotificationService.showNotification(
            title: title,
            content: content,
            notiId: const Uuid().v1().hashCode,
            payload: jsonEncode(message.data),
          );
        }
      },
    );
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
          payload: jsonEncode(message.data));
    }
  }

  Future<void> sendNotification({
    required String receiverToken,
    required String title,
    required String body,
    required String type,
    required Map<String, dynamic> payload,
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
            'messageType': type,
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': payload,
            "to": receiverToken,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
}

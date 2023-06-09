import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/route/app_route.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification({
    required String title,
    required String content,
    required int notiId,
    String? androidIconPath,
    String? payload,
  }) async {
    await _requestAndroidPermission();
    await _flutterLocalNotificationsPlugin.show(
      notiId,
      title,
      content,
      _buildNotificationDetails(androidIconPath),
      payload: payload,
    );
  }

  static Future<void> cancelScheduleNotification(int notiId) async {
    await _flutterLocalNotificationsPlugin.cancel(notiId);
    debugPrint("-------Notification removed with ID: $notiId-------");
  }

  static Future<void> cancelAllScheduleNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
    debugPrint("-------All Notification removed-------");
  }

  static void initNotificationLocal() async {
    await _initializeNotifications();
    await _requestAndroidPermission();
    await _requestIOSPermissions();
  }

  static Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    var initialize = _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onReceiveNotification,
      onDidReceiveBackgroundNotificationResponse:
          _onDidReceiveNotificationResponse,
    );
    await initialize;
  }

  static Future<void> _requestAndroidPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    androidPlugin?.requestPermission();
  }

  static Future<void> _requestIOSPermissions() async {
    final IOSFlutterLocalNotificationsPlugin? iosPlugin =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static NotificationDetails _buildNotificationDetails(
      String? androidIconPath) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'class_schedule_notification',
      'Class schedule notification',
      channelDescription: 'Class schedule notification Des',
      importance: Importance.max,
      priority: Priority.high,
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
  }

  static void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    debugPrint("-------onDidReceiveLocalNotification-------");
    debugPrint("-------id: $id-------");
    debugPrint("-------title: $title-------");
    debugPrint("-------body: $body-------");
    debugPrint("-------payload: $payload-------");
  }

  static void _onDidReceiveNotificationResponse(
      NotificationResponse details) async {
    final message = jsonDecode(details.payload!);
    if (Get.currentRoute == AppPath.chat) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = UserModel.fromJson(
        jsonDecode(message['user']),
      );
      final friend = UserModel.fromJson(
        jsonDecode(message['friend']),
      );
      final conversationId = message['conversationId'];
      if (message['type'] == 'message') {
        Get.toNamed(AppPath.chat, arguments: {
          'conversationId': conversationId,
          'user': user,
          'friend': friend,
        });
      } else {
        Get.toNamed(AppPath.call, arguments: {
          'token': conversationId,
          'user': friend,
          'friend': user,
          'isListener': true,
        });
      }
      _flutterLocalNotificationsPlugin.cancel(details.id!);
    });
  }

  static void _onReceiveNotification(NotificationResponse details) async {
    final payload = details.payload;
    final result = jsonDecode(payload!);
    final user = UserModel.fromJson(
      jsonDecode(result['user']),
    );
    final friend = UserModel.fromJson(
      jsonDecode(result['friend']),
    );
    final conversationId = result['conversationId'];
    if (result['type'] == 'message') {
      Get.toNamed(AppPath.chat, arguments: {
        'conversationId': conversationId,
        'user': user,
        'friend': friend,
      });
    } else {
      Get.toNamed(AppPath.call, arguments: {
        'token': conversationId,
        'user': friend,
        'friend': user,
        'isListener': true,
      });
    }
    cancelScheduleNotification(details.id!);
  }
}

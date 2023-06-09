import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/firebase_options.dart';
import 'package:kit_chat_app/persenstation/app.dart';
import 'package:kit_chat_app/persenstation/service/agora.dart';
import 'package:kit_chat_app/persenstation/service/firebase_message.dart';
import 'package:kit_chat_app/persenstation/service/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  // await AgoraService().setupVoiceSDKEngine();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initNotificationLocal();
  FirebaseMessagingService.init();
  runApp(const MyApp());
}

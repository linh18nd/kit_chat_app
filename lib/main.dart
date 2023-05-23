import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kit_chat_app/common/config/setup.dart';
import 'package:kit_chat_app/firebase_options.dart';
import 'package:kit_chat_app/persenstation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

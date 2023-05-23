import 'package:kit_chat_app/utils/convert/app_convert.dart';
import 'package:uuid/uuid.dart';

enum Status { online, offline }

class UserModel {
  final String? userId;
  final String username;
  final String email;
  final String avatarUrl;
  final Status status;

  UserModel({
    String? userId,
    required this.username,
    required this.email,
    required this.avatarUrl,
    this.status = Status.offline,
  }) : userId = userId ?? const Uuid().v4();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'status': AppConvert.statusToString(status),
    };
  }
}

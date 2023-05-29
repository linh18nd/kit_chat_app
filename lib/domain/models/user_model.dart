import 'package:kit_chat_app/utils/convert/app_convert.dart';
import 'package:uuid/uuid.dart';

enum Status { online, offline }

class UserModel {
  final String? userId;
  final String username;
  final String email;
  final String avatarUrl;
  final Status status;
  final List<String> friends;
  final List<String> friendRequest;

  UserModel({
    String? userId,
    required this.username,
    required this.friends,
    required this.email,
    required this.avatarUrl,
    this.friendRequest = const [],
    this.status = Status.offline,
  }) : userId = userId ?? const Uuid().v4();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      friends: List<String>.from(json['friends'] ?? []),
      status: AppConvert.stringToStatus(json['status'] ?? 'offline'),
      friendRequest: List<String>.from(json['friendRequest'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'status': AppConvert.statusToString(status),
      'friends': friends,
      'friendRequest': friendRequest,
    };
  }
}

import 'package:kit_chat_app/utils/convert/datetime_convert.dart';
import 'package:uuid/uuid.dart';

class ConversationsModel {
  final String conversationId;
  final DateTime createdAt;
  final List<String?> participants;
  final DateTime lastMessageAt;
  final String? lastMessage;

  ConversationsModel({
    String? conversationId,
    DateTime? createdAt,
    this.lastMessage = 'Cuộc trò chuyện mới',
    required this.participants,
    required this.lastMessageAt,
  })  : createdAt = DateTime.now(),
        conversationId = conversationId ?? const Uuid().v4();

  factory ConversationsModel.fromJson(Map<String, dynamic> json) {
    return ConversationsModel(
      lastMessage: json['lastMessage'],
      conversationId: json['conversationId'],
      createdAt: DateTimeConvert.convertStringToDateTime(json['createdAt']),
      participants: List<String>.from(json['participants']),
      lastMessageAt:
          DateTime.fromMillisecondsSinceEpoch(json['lastMessageAt'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'createdAt': DateTimeConvert.convertDateTimeToString(createdAt),
      'participants': participants,
      'lastMessageAt': lastMessageAt.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  ConversationsModel copyWith({
    String? conversationId,
    DateTime? createdAt,
    List<String?>? participants,
    DateTime? lastMessageAt,
    String? lastMessage,
  }) {
    return ConversationsModel(
      conversationId: conversationId ?? this.conversationId,
      createdAt: createdAt ?? this.createdAt,
      participants: participants ?? this.participants,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}

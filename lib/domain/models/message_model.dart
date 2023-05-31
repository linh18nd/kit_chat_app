import 'package:kit_chat_app/utils/convert/app_convert.dart';
import 'package:uuid/uuid.dart';

enum MessageType { text, image, video, audio, file }

class Message {
  final String? messageId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;

  Message({
    String? messageId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
  }) : messageId = messageId ?? const Uuid().v4();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: AppConvert.getMessageTypeFromString(json['type'] as String),
      messageId: json['messageId'],
      senderId: json['senderId'],
      content: json['content'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.name,
    };
  }
}

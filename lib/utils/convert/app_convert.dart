import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';

class AppConvert {
  static Status stringToStatus(String status) {
    switch (status) {
      case 'online':
        return Status.online;
      case 'offline':
        return Status.offline;
      default:
        return Status.offline;
    }
  }

  static String statusToString(Status status) {
    switch (status) {
      case Status.online:
        return 'online';
      case Status.offline:
        return 'offline';
      default:
        return 'offline';
    }
  }

  static MessageType getMessageTypeFromString(String value) {
    switch (value) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      case 'file':
        return MessageType.file;
      default:
        throw ArgumentError('Invalid MessageType: $value');
    }
  }
}

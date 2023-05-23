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
}

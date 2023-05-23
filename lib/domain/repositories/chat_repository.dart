import 'package:kit_chat_app/domain/models/message_model.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String message);

  Stream<List<Message>> getMessages();
}

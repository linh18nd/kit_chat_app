import 'package:kit_chat_app/data/repositories/remote/chat_repository.dart';
import 'package:kit_chat_app/domain/models/message_model.dart';

class ChatModelUsecase {
  final ChatModelRepository _chatModelRepository;

  ChatModelUsecase(this._chatModelRepository);

  Stream<List<Message>> getChatModels(String conversationId) {
    return _chatModelRepository.getMessages(conversationId);
  }

  Future<void> sendMessage(Message message, String conversationsId) {
    return _chatModelRepository.sendMessage(message, conversationsId);
  }
}
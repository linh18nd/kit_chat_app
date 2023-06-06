import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kit_chat_app/domain/models/message_model.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/domain/repositories/chat_repository.dart';
import 'package:kit_chat_app/persenstation/service/firebase_message.dart';

class ChatModelRepository implements ChatRepository {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseMessaging = FirebaseMessagingService();
  @override
  Stream<List<Message>> getMessages(String conversationId) {
    log('getMessages');
    try {
      final stream = _firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          log(' ${doc.data()}');
          return Message.fromJson(doc.data());
        }).toList();
      });
      return stream;
    } catch (e) {}
    return const Stream.empty();
  }

  @override
  Future<void> sendMessage(Message message, String conversationsId,
      String recipientToken, UserModel userModel) async {
    await _firestore
        .collection('conversations')
        .doc(conversationsId)
        .collection('messages')
        .add(message.toJson());
    final String content = message.type == MessageType.text
        ? message.content
        : message.type == MessageType.image
            ? 'Bạn nhận được ${message.content.split(', ').length} ảnh'
            : 'Video';
    updateLastMessage(message, conversationsId, message.type);
    _firebaseMessaging.sendNotification(
      receiverToken: recipientToken,
      title: userModel.username,
      body: content,
    );
  }

  Future<void> updateLastMessage(
      Message message, String conversationsId, MessageType messageType) async {
    await _firestore.collection('conversations').doc(conversationsId).update({
      'lastMessage': messageType == MessageType.text
          ? message.content
          : messageType == MessageType.image
              ? 'Image'
              : 'Video',
      'lastMessageAt': message.timestamp.millisecondsSinceEpoch
    });
  }
}

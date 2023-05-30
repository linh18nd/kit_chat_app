import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kit_chat_app/domain/repositories/user_repository.dart';

class UserModelRepository implements UserRepository {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<void> deleteProfile(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(
      String userId, String name, String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateStatus(
      String userId, bool isOnline, String messagingToken) async {
    return await _firestore.collection('users').doc(userId).update(
      {
        'status': isOnline ? 'online' : 'offline',
        'messagingToken': messagingToken,
      },
    );
  }
}

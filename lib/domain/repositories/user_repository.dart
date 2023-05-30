abstract class UserRepository {
  Future<void> updateStatus(
      String userId, bool isOnline, String messagingToken);
  Future<void> updateProfile(
      String userId, String name, String email, String password);
  Future<void> deleteProfile(String userId);
}

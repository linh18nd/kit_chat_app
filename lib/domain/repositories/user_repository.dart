abstract class UserRepository{
  Future<void> createUser(String userId, String name, String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> updateProfile(String userId, String name, String email, String password);
  Future<void> deleteProfile(String userId);
}
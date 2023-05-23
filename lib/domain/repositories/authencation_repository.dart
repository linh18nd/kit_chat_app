enum AuthencationType { facebook, google }

abstract class AuthencationRepository {
  Future<void> logInWithSocial(AuthencationType type);

  Future<void> logOut();

  Future<String> getUser();
}

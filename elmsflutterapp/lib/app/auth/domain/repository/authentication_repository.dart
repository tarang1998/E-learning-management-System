abstract class AuthenticationRepository {
  Future<bool> checkLoginStatus();

  Future<String> authenticateWithEmailAndPassword(
      {required String email, required String password, required bool isUserAnInstructor});

  Future<void> forgotPassword({required String emailId});

  Future<void> logout();
}

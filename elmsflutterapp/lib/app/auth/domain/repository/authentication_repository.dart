abstract class AuthenticationRepository {
  Future<bool> checkLoginStatus();

  Future<void> authenticateWithEmailAndPassword(
      {required String email, required String password});

  Future<void> forgotPassword({required String emailId});
}

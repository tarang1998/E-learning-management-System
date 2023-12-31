abstract class AuthenticationRepository {
  Future<bool> checkLoginStatus();

  Future<String> authenticateWithEmailAndPassword(
      {required String email, required String password, required bool isUserAnInstructor});

  Future<void> forgotPassword({required String emailId});

  Future<void> logout();

  Future<void> resetPassword();

  Future<void> registerStudentUser({required String userName, required String userEmail, required String password});
}

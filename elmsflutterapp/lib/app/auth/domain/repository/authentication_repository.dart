// Abstract class defining the contract for an Authentication Repository
abstract class AuthenticationRepository {
  // Method to check the login status of the user
  Future<bool> checkLoginStatus();

  // Method to authenticate a user with email and password
  Future<String> authenticateWithEmailAndPassword(
      {required String email, required String password, required bool isUserAnInstructor});

  // Method to initiate the forgot password process
  Future<void> forgotPassword({required String emailId});

  // Method to log out the user
  Future<void> logout();
}

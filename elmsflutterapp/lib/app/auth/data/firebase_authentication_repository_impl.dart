// Import statements for the required packages and classes
import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/repository/authentication_repository.dart';

// Class definition for the FirebaseAuthenticationRepository implementing AuthenticationRepository
class FirebaseAuthenticationRepository implements AuthenticationRepository {
  // Constants for different error codes related to authentication
  final String errorCodeWrongPassword = "wrong-password";
  final String errorCodeUserNotFound = "user-not-found";
  final String errorCodeInvalidEmail = "invalid-email";
  final String errorCodeNetworkRequestFailed = "network-request-failed";
  final String errorCodeTooManyRequest = "too-many-requests";

  // Method to check the login status
  @override
  Future<bool> checkLoginStatus() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? isUserAnInstructor = prefs.getInt('isUserAnInstructor');
      if (isUserAnInstructor == null) {
        return false;
      }
      // Resetting user data and setting user configuration
      UserConfig.resetUserData();
      UserConfig(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: FirebaseAuth.instance.currentUser!.email!,
          isUserAnInstructor: isUserAnInstructor == 1 ? true : false);

      return true;
    } else {
      return false;
    }
  }

  // Method to authenticate with email and password
  @override
  Future<String> authenticateWithEmailAndPassword(
      {required String email,
      required String password,
      required bool isUserAnInstructor}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('isUserAnInstructor', isUserAnInstructor ? 1 : 0);

      // Resetting user data and setting user configuration
      UserConfig.resetUserData();
      UserConfig(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          isUserAnInstructor: isUserAnInstructor);

      return FirebaseAuth.instance.currentUser!.uid;
    } on FirebaseAuthException catch (error) {
      FirebaseAuthException firebaseAuthException = error;
      String errorCode = firebaseAuthException.code;
      String? errorMessage = firebaseAuthException.message;
      print('ERROR_CODE:$errorCode');
      print('ERROR_MESSAGE:$errorMessage');
      // Handling specific authentication errors and throwing custom exceptions
      if (errorCode == errorCodeWrongPassword ||
          errorCode == errorCodeUserNotFound ||
          errorCode == errorCodeInvalidEmail) {
        throw LoginInvalidEmailPasswordException();
      } else if (errorCode == errorCodeNetworkRequestFailed) {
        throw LoginNetworkRequestFailedException();
      } else if (errorCode == errorCodeTooManyRequest) {
        throw LoginTooManyRequestException();
      } else {
        throw LoginException();
      }
    } catch (error) {
      print(error);
      throw LoginException();
    }
  }

  // Method to initiate the forgot password process
  @override
  Future<void> forgotPassword({required String emailId}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailId);
    } on FirebaseAuthException catch (error) {
      FirebaseAuthException firebaseAuthException = error;
      String errorCode = firebaseAuthException.code;
      String? errorMessage = firebaseAuthException.message;
      print('ERROR_CODE:$errorCode');
      print('ERROR_MESSAGE:$errorMessage');
      // Handling specific errors related to forgot password and throwing custom exceptions
      if (errorCode == errorCodeUserNotFound ||
          errorCode == errorCodeInvalidEmail) {
        throw ForgotPasswordInvalidEmailPasswordException();
      } else if (errorCode == errorCodeNetworkRequestFailed) {
        throw ForgotPasswordNetworkRequestFailedException();
      } else if (errorCode == errorCodeTooManyRequest) {
        throw ForgotPasswordTooManyRequestException();
      } else {
        throw ForgotPasswordException();
      }
    } catch (error) {
      throw ForgotPasswordException();
    }
  }

  // Method to log out the user
  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('isUserAnInstructor');
    // Resetting user data
    UserConfig.resetUserData();
    return;
  }
}

import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/repository/authentication_repository.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final String errorCodeWrongPassword = "wrong-password";
  final String errorCodeUserNotFound = "user-not-found";
  final String errorCodeInvalidEmail = "invalid-email";
  final String errorCodeNetworkRequestFailed = "network-request-failed";
  final String errorCodeTooManyRequest = "too-many-requests";

  @override
  Future<bool> checkLoginStatus() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      UserConfig.resetUserData();
      UserConfig(
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: FirebaseAuth.instance.currentUser!.email!,
      );

      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> authenticateWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserConfig.resetUserData();
      UserConfig(uid: FirebaseAuth.instance.currentUser!.uid, email: email);
    } on FirebaseAuthException catch (error) {
      FirebaseAuthException firebaseAuthxception = error;
      String errorCode = firebaseAuthxception.code;
      String? errorMessage = firebaseAuthxception.message;
      print('ERROR_CODE:$errorCode');
      print('ERROR_MESSAGE:$errorMessage');
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

  @override
  Future<void> forgotPassword({required String emailId}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailId);
    } on FirebaseAuthException catch (error) {
      FirebaseAuthException firebaseAuthxception = error;
      String errorCode = firebaseAuthxception.code;
      String? errorMessage = firebaseAuthxception.message;
      print('ERROR_CODE:$errorCode');
      print('ERROR_MESSAGE:$errorMessage');
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/register_student_user_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/repository/authentication_repository.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final String errorCodeWrongPassword = "wrong-password";
  final String errorCodeUserNotFound = "user-not-found";
  final String errorCodeInvalidEmail = "invalid-email";
  final String errorCodeNetworkRequestFailed = "network-request-failed";
  final String errorCodeTooManyRequest = "too-many-requests";

  final String errorCodeWeakPassword = 'weak-password';
  final String errorCodeEmailAlreadyInUse = 'email-already-in-use';

  final firebase = FirebaseFirestore.instance;

  @override
  Future<bool> checkLoginStatus() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? isUserAnInstructor = prefs.getInt('isUserAnInstructor');
      if (isUserAnInstructor == null) {
        return false;
      }
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

      UserConfig.resetUserData();
      UserConfig(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          isUserAnInstructor: isUserAnInstructor);

      return FirebaseAuth.instance.currentUser!.uid;
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

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('isUserAnInstructor');
    UserConfig.resetUserData();
    return;
  }

  @override
  Future<void> resetPassword() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.email != null) {
      print(currentUser.email);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: currentUser.email!);
    }
    return;
  }

  @override
  Future<void> registerStudentUser(
      {required String userName,
      required String userEmail,
      required String password}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: password);

      String studentId = user.user!.uid;

      await firebase
          .collection('students')
          .doc(studentId)
          .set({'id': studentId, 'name': userName, 'email': userEmail});
    } on FirebaseAuthException catch (error) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        if (currentUser.email == userEmail) {
          await currentUser.delete();
        }
      }
      if (error.code == errorCodeWeakPassword) {
        throw RegisterWeakPasswordException();
      } else if (error.code == errorCodeEmailAlreadyInUse) {
        throw RegisterEmailAlreadyInUseException();
      }
    } catch (error) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        if (currentUser.email == userEmail) {
          await currentUser.delete();
        }
      }
      throw RegisterGenericException();
    }
  }
}

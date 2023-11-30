import 'dart:async';
import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Use case class for authenticating a user with email and password
class AuthenticateWithEmailAndPasswordUseCase
    extends CompletableUseCase<AuthenticateWithEmailAndPasswordParams> {
  // Repository responsible for handling authentication-related operations
  final AuthenticationRepository _repository;

  // Constructor that takes an authentication repository as a dependency
  AuthenticateWithEmailAndPasswordUseCase(this._repository);

  // Override method to build the use case stream
  @override
  Future<Stream<String>> buildUseCaseStream(
      AuthenticateWithEmailAndPasswordParams? params) async {
    // Create a stream controller to handle the asynchronous response
    final StreamController<String> streamController = StreamController();
    try {
      // Attempt to authenticate the user using the repository
      String userId = await _repository.authenticateWithEmailAndPassword(
          email: params!._email, 
          password: params._password,
          isUserAnInstructor: params.isUserAnInstructor);
      
      // Print a success message and add the user ID to the stream
      print("Authentication successful");
      streamController.add(userId);
      streamController.close();
    } catch (error) {
      // If an error occurs during authentication, add the error to the stream
      streamController.addError(error);
      print("Authentication unsuccessful");
    }
    // Return the stream for observing the authentication process
    return streamController.stream;
  }
}

// Parameters class for the authenticateWithEmailAndPassword use case
class AuthenticateWithEmailAndPasswordParams {
  // Private properties for email, password, and user type
  String _email;
  String _password;
  bool isUserAnInstructor;

  // Constructor to initialize the parameters
  AuthenticateWithEmailAndPasswordParams(this._email, this._password, this.isUserAnInstructor);
}

// Custom exceptions for handling different authentication error scenarios
class LoginInvalidEmailPasswordException implements Exception {}

class LoginNetworkRequestFailedException implements Exception {}

class LoginTooManyRequestException implements Exception {}

class LoginException implements Exception {}

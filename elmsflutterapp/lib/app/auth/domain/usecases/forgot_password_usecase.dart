// Importing necessary Dart libraries and packages.
import 'dart:async';

// Importing a custom authentication repository.
import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Defining a use case for handling the "Forgot Password" functionality.
class ForgotPasswordUsecase extends CompletableUseCase<ForgotPasswordUsecaseParams> {
  AuthenticationRepository _repository;

  // Constructor that takes an AuthenticationRepository instance.
  ForgotPasswordUsecase(this._repository);

  // Implementation of the use case logic.
  @override
  Future<Stream<void>> buildUseCaseStream(ForgotPasswordUsecaseParams? params) async {
    // Creating a stream controller to manage the output stream.
    final StreamController streamController = StreamController();

    try {
      // Calling the forgotPassword method from the authentication repository.
      await _repository.forgotPassword(emailId: params!.emailId);
      // Printing a success message to the console.
      print("reset password success");
      // Closing the stream controller since the operation was successful.
      streamController.close();
    } catch (error) {
      // Adding an error to the stream if an exception occurs.
      streamController.addError(error);
      // Printing an error message to the console.
      print("error at Forgot Password $error");
    }

    // Returning the stream from the stream controller.
    return streamController.stream;
  }
}

// Parameters class for the ForgotPasswordUsecase.
class ForgotPasswordUsecaseParams {
  final String emailId;

  // Constructor for initializing the emailId parameter.
  ForgotPasswordUsecaseParams(this.emailId);
}

// Custom exception classes for different error scenarios.
class ForgotPasswordInvalidEmailPasswordException implements Exception {}

class ForgotPasswordNetworkRequestFailedException implements Exception {}

class ForgotPasswordTooManyRequestException implements Exception {}

class ForgotPasswordException implements Exception {}

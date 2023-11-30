import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../repository/authentication_repository.dart';

// Use case class for checking the login status
class CheckLoginStatusUsecase extends CompletableUseCase<void> {
  // Repository responsible for handling authentication-related operations
  AuthenticationRepository _repository;

  // Constructor that takes an authentication repository as a dependency
  CheckLoginStatusUsecase(this._repository);

  // Override method to build the use case stream
  @override
  Future<Stream<bool>> buildUseCaseStream(params) async {
    // Create a stream controller to handle the asynchronous response
    final StreamController<bool> streamController = StreamController();
    try {
      // Attempt to check the login status using the repository
      bool status = await _repository.checkLoginStatus();
      
      // Add the login status to the stream and close the stream
      streamController.add(status);
      streamController.close();
    } catch (error) {
      // If an error occurs during the login status check, add the error to the stream
      streamController.addError(error);
    }
    // Return the stream for observing the login status
    return streamController.stream;
  }
}


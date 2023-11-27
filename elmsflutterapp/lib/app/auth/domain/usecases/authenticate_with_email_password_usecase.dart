import 'dart:async';
import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AuthenticateWithEmailAndPasswordUseCase
    extends CompletableUseCase<AuthenticateWithEmailAndPasswordParams> {
  final AuthenticationRepository _repository;

  AuthenticateWithEmailAndPasswordUseCase(this._repository);

  @override
  Future<Stream<String>> buildUseCaseStream(
      AuthenticateWithEmailAndPasswordParams? params) async {
    final StreamController<String> streamController = StreamController();
    try {
      String userId = await _repository.authenticateWithEmailAndPassword(
          email: params!._email, 
          password: params._password,
          isUserAnInstructor: params.isUserAnInstructor);
      print("Authentication successful");
      streamController.add(userId);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
      print("Authentication unsuccessful");
    }
    return streamController.stream;
  }
}

class AuthenticateWithEmailAndPasswordParams {
  String _email;
  String _password;
  bool isUserAnInstructor;

  AuthenticateWithEmailAndPasswordParams(this._email, this._password, this.isUserAnInstructor);
}

class LoginInvalidEmailPasswordException implements Exception {}

class LoginNetworkRequestFailedException implements Exception {}

class LoginTooManyRequestException implements Exception {}

class LoginException implements Exception {}

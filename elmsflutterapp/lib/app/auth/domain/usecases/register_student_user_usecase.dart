import 'dart:async';

import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class RegisterStudentUserUsecase extends CompletableUseCase<RegisterStudentUserUsecaseParams> {
  final AuthenticationRepository _repository;

  RegisterStudentUserUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.registerStudentUser(userName: params!.userName,userEmail: params.userEmail,password: params.password );
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }

    return streamController.stream;
  }
}

class RegisterStudentUserUsecaseParams{
  String userName;
  String userEmail;
  String password;

  RegisterStudentUserUsecaseParams({
    required this.userEmail,
    required this.userName,
    required this.password
  });
}


class RegisterWeakPasswordException implements Exception {}

class RegisterEmailAlreadyInUseException implements Exception {}

class RegisterGenericException implements Exception {}

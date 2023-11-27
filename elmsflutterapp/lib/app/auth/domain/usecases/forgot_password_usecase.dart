import 'dart:async';
import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ForgotPasswordUsecase
    extends CompletableUseCase<ForgotPasswordUsecaseParams> {
  AuthenticationRepository _repository;

  ForgotPasswordUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      ForgotPasswordUsecaseParams? params) async {
    final StreamController streamController = StreamController();

    try {
      await _repository.forgotPassword(emailId: params!.emailId);
      print("reset password success");
      streamController.close();
    } catch (error) {
      streamController.addError(error);
      print("error at Forgot Password $error");
    }
    return streamController.stream;
  }
}

class ForgotPasswordUsecaseParams {
  final String emailId;

  ForgotPasswordUsecaseParams(this.emailId);
}

class ForgotPasswordInvalidEmailPasswordException implements Exception {}

class ForgotPasswordNetworkRequestFailedException implements Exception {}

class ForgotPasswordTooManyRequestException implements Exception {}

class ForgotPasswordException implements Exception {}

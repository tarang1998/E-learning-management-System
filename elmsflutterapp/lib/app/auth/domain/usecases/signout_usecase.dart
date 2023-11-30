import 'dart:async';

import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class SignoutUsecase extends CompletableUseCase<void> {
  final AuthenticationRepository _repository;

  SignoutUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.logout();
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }

    return streamController.stream;
  }
}

import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../repository/authentication_repository.dart';

class CheckLoginStatusUsecase extends CompletableUseCase<void> {
  AuthenticationRepository _repository;
  CheckLoginStatusUsecase(this._repository);

  @override
  Future<Stream<bool>> buildUseCaseStream(params) async {
    final StreamController<bool> streamController = StreamController();
    try {
      bool status = await _repository.checkLoginStatus();
      streamController.add(status);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

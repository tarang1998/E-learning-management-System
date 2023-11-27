import 'dart:async';

import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetUserDataUsecase extends CompletableUseCase<GetUserDataUsecaseParams> {
  final HomeRepository _repository;
  GetUserDataUsecase(this._repository);

  @override
  Future<Stream<UserEntity>> buildUseCaseStream(params) async {
    final StreamController<UserEntity> streamController = StreamController();
    try {
      UserEntity user = await _repository.getUserData(
          userId: params!.userId,
          isUserAnInstructor: params.isUserAnInstructor);
      streamController.add(user);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

class GetUserDataUsecaseParams {
  String userId;
  bool isUserAnInstructor;

  GetUserDataUsecaseParams(this.userId, this.isUserAnInstructor);
}

class StudentDataDoesNotExistException implements Exception {}

class InstructorDataDoesNotExistException implements Exception {}

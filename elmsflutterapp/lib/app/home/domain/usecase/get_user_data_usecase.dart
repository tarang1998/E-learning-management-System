// Importing necessary packages and classes
import 'dart:async';
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/repository/home_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Implementation of GetUserDataUsecase, extending CompletableUseCase
class GetUserDataUsecase extends CompletableUseCase<GetUserDataUsecaseParams> {
  final HomeRepository _repository;

  // Constructor to initialize the repository
  GetUserDataUsecase(this._repository);

  // Overriding the buildUseCaseStream method
  @override
  Future<Stream<UserEntity>> buildUseCaseStream(params) async {
    // Creating a StreamController for handling the asynchronous stream
    final StreamController<UserEntity> streamController = StreamController();
    try {
      // Fetching user data using the repository
      UserEntity user = await _repository.getUserData(
        userId: params!.userId,
        isUserAnInstructor: params.isUserAnInstructor,
      );
      // Adding the user data to the stream
      streamController.add(user);
      // Closing the stream after data is added
      streamController.close();
    } catch (error) {
      // Adding an error to the stream in case of an exception
      streamController.addError(error);
    }
    // Returning the stream
    return streamController.stream;
  }
}

// Parameters class for GetUserDataUsecase
class GetUserDataUsecaseParams {
  String userId;
  bool isUserAnInstructor;

  // Constructor for initializing parameters
  GetUserDataUsecaseParams(this.userId, this.isUserAnInstructor);
}

// Custom exception for when student data does not exist
class StudentDataDoesNotExistException implements Exception {}

// Custom exception for when instructor data does not exist
class InstructorDataDoesNotExistException implements Exception {}

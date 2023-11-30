// Import statements for necessary packages and classes
import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for AddCourseUsecase, which is responsible for adding a new course
class AddCourseUsecase extends CompletableUseCase<AddCourseUsecaseParams> {
  CourseRepository _repository;

  // Constructor to initialize the use case with a course repository
  AddCourseUsecase(this._repository);

  // Override method to build the use case stream
  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    // Creating a stream controller to handle the asynchronous operation
    final StreamController<void> streamController = StreamController();
    try {
      // Calling the repository method to add the course
      await _repository.addCourse(
        courseName: params!.courseName,
        courseCode: params.courseCode,
        courseDescription: params.courseDescription
      );
      // Closing the stream to signal completion
      streamController.close();
    } catch (error) {
      // Adding an error to the stream in case of an exception
      streamController.addError(error);
    }
    // Returning the stream for observing the completion of the use case
    return streamController.stream;
  }
}

// Class definition for AddCourseUsecaseParams, representing the parameters required for adding a new course
class AddCourseUsecaseParams {
  String courseName;
  String courseDescription;
  String courseCode;

  // Constructor to initialize the parameters
  AddCourseUsecaseParams({
    required this.courseName,
    required this.courseCode,
    required this.courseDescription
  });
}

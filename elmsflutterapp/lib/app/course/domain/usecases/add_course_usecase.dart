// Import statements for necessary libraries and dependencies
import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for the AddCourseUsecase, extending CompletableUseCase
class AddCourseUsecase extends CompletableUseCase<AddCourseUsecaseParams> {
  // Instance variable to hold the CourseRepository
  CourseRepository _repository;

  // Constructor to initialize the AddCourseUsecase with a CourseRepository
  AddCourseUsecase(this._repository);

  // Override method to build the use case stream
  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    // Create a StreamController to handle the stream of results
    final StreamController<void> streamController = StreamController();
    try {
      // Call the addCourse method from the repository, passing parameters from use case params
      await _repository.addCourse(
        courseName: params!.courseName,
        courseCode: params.courseCode,
        courseDescription: params.courseDescription
      );
      // Close the stream controller when the operation is successful
      streamController.close();
    } catch (error) {
      // Add an error to the stream controller if an exception occurs
      streamController.addError(error);
    }
    // Return the stream from the stream controller
    return streamController.stream;
  }
}

// Class definition for the AddCourseUsecaseParams, representing parameters for the use case
class AddCourseUsecaseParams {
  // Properties representing course details
  String courseName;
  String courseDescription;
  String courseCode;

  // Constructor to initialize AddCourseUsecaseParams with required properties
  AddCourseUsecaseParams({
    required this.courseName,
    required this.courseCode,
    required this.courseDescription
  });
}

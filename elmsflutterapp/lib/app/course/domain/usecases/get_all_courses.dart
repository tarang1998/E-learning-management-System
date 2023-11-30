// Import statements for necessary packages and classes
import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for GetAllCoursesUsecase, responsible for retrieving all courses
class GetAllCoursesUsecase extends CompletableUseCase<void> {
  CourseRepository _repository;

  // Constructor to initialize the use case with a course repository
  GetAllCoursesUsecase(this._repository);

  // Override method to build the use case stream
  @override
  Future<Stream<List<CourseEntity>>> buildUseCaseStream(params) async {
    // Creating a stream controller to handle the asynchronous operation
    final StreamController<List<CourseEntity>> streamController = StreamController();
    try {
      // Calling the repository method to get all courses
      List<CourseEntity> courses = await _repository.getAllCourses();
      // Adding the list of courses to the stream
      streamController.add(courses);
      // Closing the stream to signal completion
      streamController.close();
    } catch (error) {
      // Adding an error to the stream in case of an exception
      streamController.addError(error);
    }
    // Returning the stream for observing the result of the use case
    return streamController.stream;
  }
}

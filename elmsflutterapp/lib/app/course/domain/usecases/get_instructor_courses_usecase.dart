// Import statements for necessary libraries and dependencies
import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for the GetInstructorCoursesUsecase, extending CompletableUseCase
class GetInstructorCoursesUsecase extends CompletableUseCase<GetInstructorCoursesUsecaseParams> {
  // Instance variable to hold the CourseRepository
  CourseRepository _repository;

  // Constructor to initialize the GetInstructorCoursesUsecase with a CourseRepository
  GetInstructorCoursesUsecase(this._repository);

  // Override method to build the use case stream
  @override
  Future<Stream<List<CourseEntity>>> buildUseCaseStream(params) async {
    // Create a StreamController to handle the stream of results
    final StreamController<List<CourseEntity>> streamController = StreamController();
    try {
      // Call the getInstructorCourses method from the repository with the provided instructorId
      List<CourseEntity> courses = await _repository.getInstructorCourses(instructorId: params!.instructorId);
      // Add the list of instructor courses to the stream controller
      streamController.add(courses);
      // Close the stream controller after successfully adding the courses
      streamController.close();
    } catch (error) {
      // Add an error to the stream controller if an exception occurs
      streamController.addError(error);
    }
    // Return the stream from the stream controller
    return streamController.stream;
  }
}

// Class definition for the GetInstructorCoursesUsecaseParams
class GetInstructorCoursesUsecaseParams {
  // Parameter to store the instructorId
  String instructorId;

  // Constructor to initialize the GetInstructorCoursesUsecaseParams with an instructorId
  GetInstructorCoursesUsecaseParams(this.instructorId);
}

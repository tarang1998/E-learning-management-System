import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class AddCourseUsecase extends CompletableUseCase<AddCourseUsecaseParams> {
  CourseRepository _repository;
  AddCourseUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.addCourse(
        courseName: params!.courseName,
        courseCode: params.courseCode,
        courseDescription: params.courseDescription
      );
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}


class AddCourseUsecaseParams{
  String courseName;
  String courseDescription;
  String courseCode;

  AddCourseUsecaseParams({
    required this.courseName,
    required this.courseCode,
    required this.courseDescription
  });
}


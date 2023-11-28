import 'dart:async';

import 'package:elmsflutterapp/app/register-courses/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/register-courses/domain/repository/register_course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class GetEnrolledCoursesForStudentUsecase extends CompletableUseCase<GetEnrolledCoursesForStudentUsecaseParams> {
  RegisterCourseRepository _repository;
  GetEnrolledCoursesForStudentUsecase(this._repository);

  @override
  Future<Stream<List<CourseEntity>>> buildUseCaseStream(params) async {
    final StreamController<List<CourseEntity>> streamController = StreamController();
    try {
      List<CourseEntity> courses = await _repository.getEnrolledCoursesForStudent(studentId:params!.studentId);
      streamController.add(courses);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}


class GetEnrolledCoursesForStudentUsecaseParams {
  String studentId;

  GetEnrolledCoursesForStudentUsecaseParams(this.studentId);
}

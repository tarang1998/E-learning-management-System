import 'dart:async';

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class GetInstructorCoursesUsecase extends CompletableUseCase<GetInstructorCoursesUsecaseParams> {
  CourseRepository _repository;
  GetInstructorCoursesUsecase(this._repository);

  @override
  Future<Stream<List<CourseEntity>>> buildUseCaseStream(params) async {
    final StreamController<List<CourseEntity>> streamController = StreamController();
    try {
      List<CourseEntity> courses = await _repository.getInstructorCourses(instructorId:params!.instructorId);
      streamController.add(courses);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}


class GetInstructorCoursesUsecaseParams {
  String instructorId;

  GetInstructorCoursesUsecaseParams(this.instructorId);
}

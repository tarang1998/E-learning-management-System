import 'dart:async';

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetCoursesYetToBeRegistereCoursesdUsecase extends CompletableUseCase<GetCoursesYetToBeRegisteredUsecaseParams> {
  CourseRepository _repository;
  GetCoursesYetToBeRegistereCoursesdUsecase(this._repository);

  @override
  Future<Stream<List<CourseEntity>>> buildUseCaseStream(params) async {
    final StreamController<List<CourseEntity>> streamController =
        StreamController();
    try {
      List<CourseEntity> courses = await _repository.getCoursesYetToBeRegistered(studentId: params!.studentId);
      streamController.add(courses);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

class GetCoursesYetToBeRegisteredUsecaseParams {
  String studentId;

  GetCoursesYetToBeRegisteredUsecaseParams(this.studentId);
}

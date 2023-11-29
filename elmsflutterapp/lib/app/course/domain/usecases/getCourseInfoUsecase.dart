import 'dart:async';

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class GetCourseInfoUsecase extends CompletableUseCase<GetCourseInfoUsecaseParams> {
  CourseRepository _repository;
  GetCourseInfoUsecase(this._repository);

  @override
  Future<Stream<CourseEntity>> buildUseCaseStream(params) async {
    final StreamController<CourseEntity> streamController = StreamController();
    try {
      CourseEntity courses = await _repository.getCourseInfo(courseId: params!.courseId);
      streamController.add(courses);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}


class GetCourseInfoUsecaseParams{
  String courseId;
  GetCourseInfoUsecaseParams({required this.courseId});
}

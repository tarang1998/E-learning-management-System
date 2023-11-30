import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class EnrollToCourseUsecase extends CompletableUseCase<EnrollToCourseUsecaseParams> {
  CourseRepository _repository;
  EnrollToCourseUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.enrollToCourse(
        params!.studentId,
        params.courseId
      );
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}


class EnrollToCourseUsecaseParams{
  String studentId;
  String courseId;

  EnrollToCourseUsecaseParams({
    required this.studentId,
    required this.courseId,
  });
}


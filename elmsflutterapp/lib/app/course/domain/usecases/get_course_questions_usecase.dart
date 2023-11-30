import 'dart:async';

import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';


class GetCourseQuestionsUsecase extends CompletableUseCase<GetCourseQuestionsUsecaseParams> {
  CourseRepository _repository;
  GetCourseQuestionsUsecase(this._repository);

  @override
  Future<Stream<List<QuestionEntity>>> buildUseCaseStream(params) async {
    final StreamController<List<QuestionEntity>> streamController = StreamController();
    try {
      List<QuestionEntity> questions = await _repository.getCourseQuestions(courseId: params!.courseId);
      streamController.add(questions);
      streamController.close();
    } catch (error) {
      streamController.addError(error);
    }
    return streamController.stream;
  }
}


class GetCourseQuestionsUsecaseParams{
  String courseId;
  GetCourseQuestionsUsecaseParams({required this.courseId});
}

import 'dart:async';
import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddMCQQuestionUsecase
    extends CompletableUseCase<AddMCQQuestionUsecaseParams> {
  CourseRepository _repository;
  AddMCQQuestionUsecase(this._repository);

  @override
  Future<Stream<void>> buildUseCaseStream(params) async {
    final StreamController<void> streamController = StreamController();
    try {
      await _repository.addMCQQuestion(
        courseId: params!.courseId,
        questionText: params.questionText,
        marks: params.marks,
        optionMedia: params.optionMedia,
        options: params.options,
        questionImages: params.questionImages,
        questionSolutionImages: params.questionSolutionImages,
        questionSolutionText: params.questionSolutionText
      );
      streamController.close();
    } catch (error) {
      print(error);
      streamController.addError(error);
    }
    return streamController.stream;
  }
}

class AddMCQQuestionUsecaseParams {
  String courseId;
  String questionText;
  num marks;
  List<PlatformFile> questionImages;
  Map<int, List<PlatformFile>?>? optionMedia;
  List<MCQOptionEntity> options;
  String questionSolutionText;
  List<PlatformFile> questionSolutionImages;

  AddMCQQuestionUsecaseParams(
      {required this.courseId,
      required this.questionText,
      required this.marks,
      required this.questionImages,
      required this.optionMedia,
      required this.options,
      required this.questionSolutionText,
      required this.questionSolutionImages});
}

import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/add_mcq_question_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MCQQuestionPresenter extends Presenter {
  final AddMCQQuestionUsecase _addMCQQuestionUsecase;

  MCQQuestionPresenter(this._addMCQQuestionUsecase);

  @override
  void dispose() {
    _addMCQQuestionUsecase.dispose();
  }

  void addMCQQuestion(UseCaseObserver observer,
      {required String courseId,
      required String questionText,
      required num marks,
      required List<PlatformFile> questionImages,
      required Map<int, List<PlatformFile>?>? optionMedia,
      required List<MCQOptionEntity> options,
      required String questionSolutionText,
      required List<PlatformFile> questionSolutionImages}) {
    _addMCQQuestionUsecase.execute(
        observer,
        AddMCQQuestionUsecaseParams(
            courseId: courseId,
            questionText: questionText,
            marks: marks,
            questionImages: questionImages,
            optionMedia: optionMedia,
            options: options,
            questionSolutionText: questionSolutionText,
            questionSolutionImages: questionSolutionImages));
  }
}

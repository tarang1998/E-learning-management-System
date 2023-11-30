import 'package:elmsflutterapp/app/course/domain/usecases/get_course_questions_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../../core/presentation/observer.dart';

class QuestionBankPresenter extends Presenter {
  final GetCourseQuestionsUsecase _getCourseQuestionsUsecase;
  

  QuestionBankPresenter(
    this._getCourseQuestionsUsecase,
  );

  @override
  void dispose() {
    _getCourseQuestionsUsecase.dispose();
  }

  void getQuestionForCourse(
    UseCaseObserver observer, {
    required String courseId,
  }) {
    _getCourseQuestionsUsecase.execute(
      observer,
      GetCourseQuestionsUsecaseParams(
       courseId: courseId
      ),
    );
  }


}

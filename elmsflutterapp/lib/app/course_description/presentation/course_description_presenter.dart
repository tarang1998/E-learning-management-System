import 'package:elmsflutterapp/app/course/domain/usecases/getCourseInfoUsecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../core/presentation/observer.dart';

class CourseDescriptionMainPagePresenter extends Presenter {
  final GetCourseInfoUsecase _getCourseInfoUsecase;

  CourseDescriptionMainPagePresenter(
    this._getCourseInfoUsecase,
  );

  @override
  void dispose() {
    _getCourseInfoUsecase.dispose();
  }

  void getCourseInfo(UseCaseObserver observer, {required String courseId}) {
    _getCourseInfoUsecase.execute(
        observer, GetCourseInfoUsecaseParams(courseId: courseId));
  }
}

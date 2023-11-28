import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_instructor_courses_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class InstructorCoursesPresenter extends Presenter {
  final GetInstructorCoursesUsecase?
      _getInstructorCoursesUsecase;

  InstructorCoursesPresenter(
    this._getInstructorCoursesUsecase,
  );

  @override
  void dispose() {
    _getInstructorCoursesUsecase!.dispose();
  }

  void getInstructorCourses({required UseCaseObserver observer}) {
    _getInstructorCoursesUsecase!.execute(observer,
        GetInstructorCoursesUsecaseParams(UserConfig.instance!.uid));
  }
}

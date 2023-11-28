import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/register-courses/domain/usecases/get_courses_yet_to_registered.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RegisterCoursePresenter extends Presenter {
  final GetCoursesYetToBeRegistereCoursesdUsecase?
      _getCoursesYetToBeRegistereCoursesdUsecase;

  RegisterCoursePresenter(
    this._getCoursesYetToBeRegistereCoursesdUsecase,
  );

  @override
  void dispose() {
    _getCoursesYetToBeRegistereCoursesdUsecase!.dispose();
  }

  void getYetToBeRegisteredCourses({required UseCaseObserver observer}) {
    _getCoursesYetToBeRegistereCoursesdUsecase!.execute(observer,
        GetCoursesYetToBeRegisteredUsecaseParams(UserConfig.instance!.uid));
  }
}

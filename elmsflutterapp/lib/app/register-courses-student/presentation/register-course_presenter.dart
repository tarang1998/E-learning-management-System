import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/enroll_to_course_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_courses_yet_to_registered.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RegisterCoursePresenter extends Presenter {
  final GetCoursesYetToBeRegistereCoursesdUsecase?
      _getCoursesYetToBeRegistereCoursesdUsecase;
  final EnrollToCourseUsecase _enrollToCourseUsecase;

  RegisterCoursePresenter(this._getCoursesYetToBeRegistereCoursesdUsecase,
      this._enrollToCourseUsecase);

  @override
  void dispose() {
    _getCoursesYetToBeRegistereCoursesdUsecase!.dispose();
    _enrollToCourseUsecase.dispose();
  }

  void getYetToBeRegisteredCourses({required UseCaseObserver observer}) {
    _getCoursesYetToBeRegistereCoursesdUsecase!.execute(observer,
        GetCoursesYetToBeRegisteredUsecaseParams(UserConfig.instance!.uid));
  }

  void enrollToCourse(
      {required UseCaseObserver observer,
      required String studentId,
      required String courseId}) {
    _enrollToCourseUsecase.execute(observer,
        EnrollToCourseUsecaseParams(studentId: studentId, courseId: courseId));

  }
}

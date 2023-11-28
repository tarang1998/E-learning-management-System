import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_enrolled_courses_for_student_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DashboardPresenter extends Presenter {
  final GetEnrolledCoursesForStudentUsecase _getEnrolledCoursesForStudentUsecase;

  DashboardPresenter(
    this._getEnrolledCoursesForStudentUsecase,
  );

  @override
  void dispose() {
    _getEnrolledCoursesForStudentUsecase.dispose();
  }

  void getEnrolledCoursesForStudent({required UseCaseObserver observer}) {
    _getEnrolledCoursesForStudentUsecase.execute(
      observer,GetEnrolledCoursesForStudentUsecaseParams(UserConfig.instance!.uid)
    );
  }
}

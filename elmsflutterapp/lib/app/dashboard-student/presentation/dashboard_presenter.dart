// Importing necessary packages and classes
import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_enrolled_courses_for_student_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for DashboardPresenter
class DashboardPresenter extends Presenter {
  // Instance of the GetEnrolledCoursesForStudentUsecase to handle getting enrolled courses
  final GetEnrolledCoursesForStudentUsecase _getEnrolledCoursesForStudentUsecase;

  // Constructor to initialize the presenter with the required use case
  DashboardPresenter(
    this._getEnrolledCoursesForStudentUsecase,
  );

  // Method to dispose of resources when the presenter is no longer needed
  @override
  void dispose() {
    _getEnrolledCoursesForStudentUsecase.dispose();
  }

  // Method to get enrolled courses for a student and notify the observer
  void getEnrolledCoursesForStudent({required UseCaseObserver observer}) {
    // Executing the use case with the provided observer and user ID
    _getEnrolledCoursesForStudentUsecase.execute(
      observer,
      GetEnrolledCoursesForStudentUsecaseParams(UserConfig.instance!.uid),
    );
  }
}

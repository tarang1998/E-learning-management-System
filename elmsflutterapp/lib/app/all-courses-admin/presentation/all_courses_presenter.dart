import 'package:elmsflutterapp/app/course/domain/usecases/add_course_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_all_courses.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AllCoursesPresenter extends Presenter {
  final GetAllCoursesUsecase? _getAllCoursesUsecase;
  final AddCourseUsecase _addCourseUsecase;

  AllCoursesPresenter(this._getAllCoursesUsecase, this._addCourseUsecase);

  @override
  void dispose() {
    _getAllCoursesUsecase!.dispose();
    _addCourseUsecase.dispose();
  }

  void getAllCourses({required UseCaseObserver observer}) {
    _getAllCoursesUsecase!.execute(
      observer,
    );
  }

  void addCourse(
      {required UseCaseObserver observer,
      required String courseName,
      required String courseCode,
      required String courseDescription}) {
    _addCourseUsecase.execute(
        observer,
        AddCourseUsecaseParams(
            courseName: courseName,
            courseCode: courseCode,
            courseDescription: courseDescription));
  }
}

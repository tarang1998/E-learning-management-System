// Import statements for the required packages and classes
import 'package:elmsflutterapp/app/course/domain/usecases/add_course_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_all_courses.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for the AllCoursesPresenter, extending the Presenter class
class AllCoursesPresenter extends Presenter {
  // Instance variables for the use cases responsible for fetching all courses and adding a new course
  final GetAllCoursesUsecase? _getAllCoursesUsecase;
  final AddCourseUsecase _addCourseUsecase;

  // Constructor for initializing the presenter with the required use cases
  AllCoursesPresenter(this._getAllCoursesUsecase, this._addCourseUsecase);

  // Method to dispose of the use cases when the presenter is no longer needed
  @override
  void dispose() {
    _getAllCoursesUsecase!.dispose();
    _addCourseUsecase.dispose();
  }

  // Method to initiate the process of fetching all courses
  void getAllCourses({required UseCaseObserver observer}) {
    // Execute the 'GetAllCourses' use case with the provided observer
    _getAllCoursesUsecase!.execute(
      observer,
    );
  }

  // Method to initiate the process of adding a new course
  void addCourse(
      {required UseCaseObserver observer,
      required String courseName,
      required String courseCode,
      required String courseDescription}) {
    // Execute the 'AddCourse' use case with the provided observer and parameters
    _addCourseUsecase.execute(
        observer,
        AddCourseUsecaseParams(
            courseName: courseName,
            courseCode: courseCode,
            courseDescription: courseDescription));
  }
}

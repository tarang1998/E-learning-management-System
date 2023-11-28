import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_presenter.dart';
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_state_machine.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllCoursesController extends Controller {
  final AllCoursesPageStateMachine _stateMachine = AllCoursesPageStateMachine();
  final AllCoursesPresenter _presenter;
  final NavigationService? _navigationService =
      serviceLocator<NavigationService>();

  AllCoursesController()
      : _presenter = serviceLocator<AllCoursesPresenter>(),
        super();

  @override
  void initListeners() {}

  void initializeScreen() {
    _presenter.getAllCourses(
        observer: UseCaseObserver(() {}, (error) {
      _stateMachine.onEvent(AllCoursesPageErrorEvent());
      refreshUI();
    }, onNextFunc: (List<CourseEntity> courses) {
      _stateMachine.onEvent(AllCoursesPageInitializedEvent(courses: courses));
      refreshUI();
    }));
  }

  AllCoursesPageState getCurrentState() {
    return _stateMachine.getCurrentState()!;
  }

  void refreshPage() {
    _stateMachine.onEvent(AllCoursesPageRefreshEvent());
    refreshUI();
  }

  void handleBackEvent() {
    _navigationService!.navigateBack();
  }

  void addCourse(
      {required String courseName,
      required String courseCode,
      required String courseDescription}) {
    _navigationService!.navigateBack();

    _stateMachine.onEvent(AllCoursesPageLoadingEvent());
    refreshUI();

    _presenter.addCourse(
        observer: UseCaseObserver(() {
          Fluttertoast.showToast(msg: "Course added successfully");
          refreshPage();
        }, (error) {
          Fluttertoast.showToast(msg: "Failed to add course");
          refreshPage();
        }),
        courseName: courseName,
        courseCode: courseCode,
        courseDescription: courseDescription);
  }
}

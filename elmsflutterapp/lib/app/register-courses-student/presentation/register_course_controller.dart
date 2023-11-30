import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register-course_presenter.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register_course_state_machine.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterCourseController extends Controller {
  final RegisterCoursePageStateMachine _stateMachine =
      RegisterCoursePageStateMachine();
  final RegisterCoursePresenter _presenter;
  final NavigationService _navigationService = serviceLocator<NavigationService>();
  RegisterCourseController()
      : _presenter = serviceLocator<RegisterCoursePresenter>(),
        super();

  @override
  void initListeners() {}

  void initializeScreen() {
    _presenter.getYetToBeRegisteredCourses(
        observer: UseCaseObserver(() {}, (error) {
      _stateMachine.onEvent(RegisterCoursePageErrorEvent());
      refreshUI();
    }, onNextFunc: (List<CourseEntity> courses) {
      _stateMachine
          .onEvent(RegisterCoursePageInitializedEvent(courses: courses));
      refreshUI();
    }));
  }

  RegisterCoursePageState getCurrentState() {
    return _stateMachine.getCurrentState()!;
  }

  void refreshPage() {
    _stateMachine.onEvent(RegisterCoursePageRefreshEvent());
    refreshUI();
  }

  void enrollToCourse({required String courseId}) {
    _stateMachine.onEvent(RegisterCoursePageLoadingEvent());
    refreshUI();

    _presenter.enrollToCourse(
        observer: UseCaseObserver(() {
          _navigationService.navigateBack();
          Fluttertoast.showToast(msg: "Enrolled to the course Successfully");
          initializeScreen();
        }, (error) {}),
        studentId: UserConfig.instance!.uid,
        courseId: courseId);
  }
}

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register-course_presenter.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register_course_state_machine.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RegisterCourseController extends Controller {
  final RegisterCoursePageStateMachine _stateMachine =
      RegisterCoursePageStateMachine();
  final RegisterCoursePresenter _presenter;
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
}

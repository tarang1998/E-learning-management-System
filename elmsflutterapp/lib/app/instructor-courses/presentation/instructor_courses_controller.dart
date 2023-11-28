import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/instructor-courses/presentation/instructor-courses_presenter.dart';
import 'package:elmsflutterapp/app/instructor-courses/presentation/instructor_courses_state_machine.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class InstructorCoursesController extends Controller {
  final InstructorCoursesPageStateMachine _stateMachine =
      InstructorCoursesPageStateMachine();
  final InstructorCoursesPresenter _presenter;
  InstructorCoursesController()
      : _presenter = serviceLocator<InstructorCoursesPresenter>(),
        super();

  @override
  void initListeners() {}

  void initializeScreen() {
    _presenter.getInstructorCourses(
        observer: UseCaseObserver(() {}, (error) {
      _stateMachine.onEvent(InstructorCoursesPageErrorEvent());
      refreshUI();
    }, onNextFunc: (List<CourseEntity> courses) {
      _stateMachine
          .onEvent(InstructorCoursesPageInitializedEvent(courses: courses));
      refreshUI();
    }));
  }

  InstructorCoursesPageState getCurrentState() {
    return _stateMachine.getCurrentState()!;
  }

  void refreshPage() {
    _stateMachine.onEvent(InstructorCoursesPageRefreshEvent());
    refreshUI();
  }
}

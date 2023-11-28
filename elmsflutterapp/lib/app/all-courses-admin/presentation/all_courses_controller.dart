import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_presenter.dart';
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_state_machine.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AllCoursesController extends Controller {
  final AllCoursesPageStateMachine _stateMachine =
      AllCoursesPageStateMachine();
  final AllCoursesPresenter _presenter;
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
      _stateMachine
          .onEvent(AllCoursesPageInitializedEvent(courses: courses));
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
}

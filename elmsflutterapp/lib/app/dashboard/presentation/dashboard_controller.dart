import 'package:elmsflutterapp/app/dashboard/presentation/dashboard_presenter.dart';
import 'package:elmsflutterapp/app/dashboard/presentation/dashboard_state_machine.dart';
import 'package:elmsflutterapp/app/register-courses/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DashboardController extends Controller {
  final DashboardPageStateMachine _stateMachine =
      DashboardPageStateMachine();
  final DashboardPresenter _presenter;
  DashboardController()
      : _presenter = serviceLocator<DashboardPresenter>(),
        super();

  @override
  void initListeners() {}

  void initializeScreen() {
    _presenter.getEnrolledCoursesForStudent(
        observer: UseCaseObserver(() {}, (error) {
      _stateMachine.onEvent(DashboardPageErrorEvent());
      refreshUI();
    }, onNextFunc: (List<CourseEntity> courses) {
      _stateMachine
          .onEvent(DashboardPageInitializedEvent(courses: courses));
      refreshUI();
    }));
  }

  DashboardPageState getCurrentState() {
    return _stateMachine.getCurrentState()!;
  }

  void refreshPage() {
    _stateMachine.onEvent(DashboardPageRefreshEvent());
    refreshUI();
  }
}

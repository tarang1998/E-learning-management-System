// Importing necessary packages and classes
import 'package:elmsflutterapp/app/dashboard-student/presentation/dashboard_presenter.dart';
import 'package:elmsflutterapp/app/dashboard-student/presentation/dashboard_state_machine.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Class definition for DashboardController
class DashboardController extends Controller {
  // Instance of DashboardPageStateMachine to manage state transitions
  final DashboardPageStateMachine _stateMachine = DashboardPageStateMachine();
  
  // Instance of DashboardPresenter for handling presentation logic
  final DashboardPresenter _presenter;

  // Constructor to initialize the controller with a presenter and call the superclass constructor
  DashboardController()
      : _presenter = serviceLocator<DashboardPresenter>(),
        super();

  // Method to initialize listeners
  @override
  void initListeners() {}

  // Method to initialize the screen by fetching enrolled courses for a student
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

  // Method to get the current state of the dashboard page
  DashboardPageState getCurrentState() {
    return _stateMachine.getCurrentState()!;
  }

  // Method to refresh the page by triggering a state transition
  void refreshPage() {
    _stateMachine.onEvent(DashboardPageRefreshEvent());
    refreshUI();
  }
}

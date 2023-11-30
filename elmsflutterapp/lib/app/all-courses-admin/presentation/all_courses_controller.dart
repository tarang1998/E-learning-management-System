// Import statements for the required packages and classes
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_presenter.dart';
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_state_machine.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Class definition for the AllCoursesController, extending the Controller class
class AllCoursesController extends Controller {
  // Instance of the state machine to manage the state of the 'All Courses' page
  final AllCoursesPageStateMachine _stateMachine = AllCoursesPageStateMachine();

  // Presenter responsible for handling business logic related to all courses
  final AllCoursesPresenter _presenter;

  // Service for navigating between different screens/pages
  final NavigationService? _navigationService = serviceLocator<NavigationService>();

  // Constructor for initializing the controller
  AllCoursesController()
      : _presenter = serviceLocator<AllCoursesPresenter>(),
        super();

  // Initialization of listeners (currently empty)
  @override
  void initListeners() {}

  // Method to initialize the screen by fetching all courses
  void initializeScreen() {
    _presenter.getAllCourses(
        observer: UseCaseObserver(() {}, (error) {
      // Handle error event by updating the state machine and refreshing the UI
      _stateMachine.onEvent(AllCoursesPageErrorEvent());
      refreshUI();
    }, onNextFunc: (List<CourseEntity> courses) {
      // Handle successful course retrieval by updating the state machine and refreshing the UI
      _stateMachine.onEvent(AllCoursesPageInitializedEvent(courses: courses));
      refreshUI();
    }));
  }

  // Method to get the current state of the 'All Courses' page
  AllCoursesPageState getCurrentState() {
    return _stateMachine.getCurrentState()!;
  }

  // Method to trigger a refresh of the 'All Courses' page
  void refreshPage() {
    _stateMachine.onEvent(AllCoursesPageRefreshEvent());
    refreshUI();
  }

  // Method to handle the back button event by navigating back
  void handleBackEvent() {
    _navigationService!.navigateBack();
  }

  // Method to add a new course
  void addCourse(
      {required String courseName,
      required String courseCode,
      required String courseDescription}) {
    // Navigate back to the previous screen
    _navigationService!.navigateBack();

    // Update the state to indicate that the page is in a loading state
    _stateMachine.onEvent(AllCoursesPageLoadingEvent());
    refreshUI();

    // Call the presenter to add the course, and handle success or failure
    _presenter.addCourse(
        observer: UseCaseObserver(() {
          // Show a toast message for successful course addition
          Fluttertoast.showToast(msg: "Course added successfully");
          // Refresh the 'All Courses' page
          refreshPage();
        }, (error) {
          // Show a toast message for failed course addition
          Fluttertoast.showToast(msg: "Failed to add course");
          // Refresh the 'All Courses' page
          refreshPage();
        }),
        courseName: courseName,
        courseCode: courseCode,
        courseDescription: courseDescription);
  }
}

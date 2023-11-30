// Importing necessary packages and classes
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/presentation/home-instructor/home_presentor.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'home_state_machine.dart';

// Controller class for the HomePageInstructor
class HomePageInstructorController extends Controller {
  // Presenter for handling business logic
  final HomePageInstructorPresenter? _presenter;
  // State machine for managing different states of the home page
  final HomePageInstructorStateMachine _stateMachine =
      HomePageInstructorStateMachine();
  // Navigation service for handling page navigation
  NavigationService? navigationService = serviceLocator<NavigationService>();

  // Constructor to initialize dependencies
  HomePageInstructorController()
      : _presenter = serviceLocator<HomePageInstructorPresenter>(),
        super();

  // Overriding method to initialize listeners
  @override
  void initListeners() {}

  // Method to initialize the home page
  void initializePage() async {
    // Executing the use case to get instructor data
    _presenter!.getInstructorData(
        observer: UseCaseObserver(() {}, (error) {
      // Handling error event and updating the state
      _stateMachine.onEvent(HomePageInstructorErrorEvent(error));
      // Refreshing the UI to reflect the state change
      refreshUI();
    }, onNextFunc: (InstructorUserEntity user) {
      // Handling success event and updating the state with instructor data
      _stateMachine.onEvent(HomePageInstructorInitializedEvent(user, 0));
      // Refreshing the UI to reflect the state change
      refreshUI();
    }));
  }

  // Method to handle tab clicks and page changes
  void handlePageChange(InstructorUserEntity instructorUserEntity, int page) {
    // Handling tab click event and updating the state
    _stateMachine
        .onEvent(HomePageInstructorTabClickEvent(instructorUserEntity, page));
    // Refreshing the UI to reflect the state change
    refreshUI();
  }

  // Method to navigate to the profile page
  void navigateToProfilePage() {}

  // Method to get the current state of the home page
  HomePageInstructorState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }
}

import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/presentation/home-student/home_presenter.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_state_machine.dart';

class HomePageStudentController extends Controller {
  // Instance of HomePageStudentPresenter for managing presentation logic.
  final HomePageStudentPresenter? _presenter;

  // State machine for handling different states of the home page.
  final HomePageStudentStateMachine _stateMachine =
      HomePageStudentStateMachine();

  // Service for navigation between different pages.
  NavigationService? navigationService = serviceLocator<NavigationService>();

  // Constructor for initializing the controller.
  HomePageStudentController()
      : _presenter = serviceLocator<HomePageStudentPresenter>(),
        super();

  @override
  void initListeners() {}

  // Method to initialize the home screen by fetching user data.
  void initializeHomeScreen() async {
    _presenter!.getUserData(
      observer: UseCaseObserver(() {}, (error) {
        _stateMachine.onEvent(HomePageStudentErrorEvent(error));
        refreshUI();
      }, onNextFunc: (StudentUserEntity userData) {
        _stateMachine.onEvent(HomePageStudentInitializedEvent(userData));
        refreshUI();
      }),
    );
  }

  // Method to navigate to the user's profile page.
  void navigateToProfilePage() {
    // Uncomment the following line when the profile page navigation is implemented.
    // navigationService!.navigateTo(NavigationService.profilePage);
  }

  // Method to handle page change events.
  void handlePageChange(StudentUserEntity studentData, int page) {
    _stateMachine.onEvent(HomePageStudentTabClickEvent(studentData, page));
    refreshUI();
  }

  // Method to handle the "Contact Support" button click.
  void handleContactSupportButtonClicked() async {
    _presenter!.getUserData(
        observer: UseCaseObserver(() {}, (error) {},
            onNextFunc: (StudentUserEntity studentData) async {
          String studentId = studentData.id;
          String studentName = studentData.name;

          // Create a mailto URI for launching the email client.
          final Uri params = Uri(
            scheme: 'mailto',
            path: 'tarang98@umd.edu',
            query: 'subject=Problems faced by the Student while using SkillsBerg&body=User Id: $studentId\nStudent Name: $studentName\n\n' +
                'We are sorry for the inconvenience faced by you.\nPlease write your problems here in as much detail as possible.\n\n',
          );

          try {
            // Launch the default email client with the mailto URI.
            await launchUrl(params);
          } catch (error) {
            print(error);
          }
        }));
  }

  // Method to get the current state of the home page.
  HomePageStudentState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }
}

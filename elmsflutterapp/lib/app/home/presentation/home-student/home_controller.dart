import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/presentation/home-student/home_presentor.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_state_machine.dart';

class HomePageStudentController extends Controller {
  final HomePageStudentPresenter? _presenter;
  final HomePageStudentStateMachine _stateMachine =
      HomePageStudentStateMachine();
  NavigationService? navigationService = serviceLocator<NavigationService>();

  HomePageStudentController()
      : _presenter = serviceLocator<HomePageStudentPresenter>(),
        super();

  @override
  void initListeners() {}

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

  void navigateToProfilePage() {
    // navigationService!.navigateTo(NavigationService.profilePage);
  }

  void handlePageChange(StudentUserEntity studentData, int page) {
    _stateMachine.onEvent(HomePageStudentTabClickEvent(studentData, page));
    refreshUI();
  }

  void handleContactSupportButtonClicked() async{
    _presenter!.getUserData(
        observer: UseCaseObserver(() {}, (error) {},
            onNextFunc: (StudentUserEntity studentData) async{
      String studentId = studentData.id;
      String studentName = studentData.name;
      final Uri params = Uri(
        scheme: 'mailto',
        path: 'tarang98@umd.edu',
        query: 'subject=Problems faced by the Student while using SkillsBerg&body=User Id: $studentId\nStudent Name: $studentName\n\n' +
            'We are sorry for the inconvenience faced by you.\nPlease write your problems here in as much detail as possible.\n\n',
      );
        try {
          await launchUrl(params);
        } catch (error) {
          print(error);
        }
     
    }));
  }

  HomePageStudentState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  // handleBottomBarPageRoute(int _page) {
  //   _stateMachine.onEvent(new HomePageTabClickEvent(this._profile, _page));
  //   refreshUI();
  // }
}

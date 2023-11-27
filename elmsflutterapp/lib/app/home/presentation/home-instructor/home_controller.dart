import 'package:elmsflutterapp/app/home/presentation/home-student/home_presentor.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
// import 'home_presentor.dart';
import 'home_state_machine.dart';

class HomePageController extends Controller {
  // final HomePagePresenter? _presenter;
  final HomePageStateMachine _stateMachine = new HomePageStateMachine();
  NavigationService? navigationService = serviceLocator<NavigationService>();

  // HomePageController()
  //     : _presenter = serviceLocator<HomePagePresenter>(),
  //       super();

  @override
  void initListeners() {}

  // void getProfileInfo() async {
  //   _presenter!.getStudentData(
  //       observer: new UseCaseObserver(
  //           _handleInitializationCompleted, _handleGetProfileInfoError,
  //           onNextFunc: _handleProfileEntity));
  // }

  // void navigateToProfilePage() {
  //   navigationService!.navigateTo(NavigationService.profilePage);
  // }

  // void handleContactSupportButtonClicked() {
  //   _presenter!.getStudentData(
  //       observer: new UseCaseObserver(() {}, (Exception error) {
  //     print('Error ocurred while getting student Data:$error');
  //   }, onNextFunc: (StudentEntity studentData) {
  //     String studentId = studentData.studentId;
  //     String studentName = studentData.name;
  //     String instituteId = studentData.institutes[0].instituteId;
  //     _presenter!.getDeviceInformation(new UseCaseObserver(() {}, (error) {
  //       print('Error ocurred while getting device information:$error');
  //     }, onNextFunc: (DeviceInformationEntity deviceInformation) async {
  //       final Uri params = Uri(
  //         scheme: 'mailto',
  //         path: 'promexa-feedback@cerebranium.com',
  //         query: 'subject=Problems faced by the Student while using the Promexa App&body=User Id: $studentId\nInstituteId: $instituteId\nStudent Name: $studentName\n' +
  //             generateDeviceInformationTextForMail(deviceInformation) +
  //             'We are sorry for the inconvenience faced by you. Please write your problems here in as much detail as possible.\n\n',
  //       );
  //       var url = params.toString();
  //       try {
  //         await launch(url);
  //       } catch (error) {
  //         ApplicationTracker.reportError(
  //             'Error encountered while launching Uri for contact support: $url , Error : $error ');
  //       }
  //     }));
  //   }));
  // }

  HomePageState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  // _handleInitializationCompleted() {
  //   _stateMachine.onEvent(new HomePageInitializedEvent(_profile!.userName));
  //   refreshUI();
  // }

  // _handleGetProfileInfoError(error) {
  //   _stateMachine.onEvent(new HomePageErrorEvent(error));
  //   print("Home Page error - " + error.toString());
  //   refreshUI();
  // }

  // _handleProfileEntity(StudentEntity studentData) {
  //   this._profile = new ProfileEntity(studentData.name);
  // }

  // handleBottomBarPageRoute(int _page) {
  //   _stateMachine.onEvent(new HomePageTabClickEvent(this._profile, _page));
  //   refreshUI();
  // }
}

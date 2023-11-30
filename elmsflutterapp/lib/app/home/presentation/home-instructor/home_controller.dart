import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/presentation/home-instructor/home_presentor.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'home_state_machine.dart';

class HomePageInstructorController extends Controller {
  final HomePageInstructorPresenter? _presenter;
  final HomePageInstructorStateMachine _stateMachine =
      HomePageInstructorStateMachine();
  NavigationService? navigationService = serviceLocator<NavigationService>();

  HomePageInstructorController()
      : _presenter = serviceLocator<HomePageInstructorPresenter>(),
        super();

  @override
  void initListeners() {}

  void initializePage() async {
    _presenter!.getInstructorData(
        observer: UseCaseObserver(() {}, (error) {
      _stateMachine.onEvent(HomePageInstructorErrorEvent(error));
      refreshUI();
    }, onNextFunc: (InstructorUserEntity user) {
      _stateMachine.onEvent(HomePageInstructorInitializedEvent(user, 0));
      refreshUI();
    }));
  }

  void handlePageChange(InstructorUserEntity instructorUserEntity, int page) {
    _stateMachine
        .onEvent(HomePageInstructorTabClickEvent(instructorUserEntity, page));
    refreshUI();
  }

  void navigateToProfilePage() {
    navigationService!.navigateTo(NavigationService.profilePage);
  }

  HomePageInstructorState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }
}

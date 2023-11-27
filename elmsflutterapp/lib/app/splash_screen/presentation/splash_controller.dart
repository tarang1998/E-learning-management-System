import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../core/presentation/observer.dart';
import '../../../injection_container.dart';
import '../../navigation_service.dart';
import 'splash_presenter.dart';
import 'splash_state_machine.dart';

class SplashController extends Controller {
  final SplashPresenter? _presenter;
  final SplashStateMachine _stateMachine = new SplashStateMachine();
  final NavigationService? _navigationService =
      serviceLocator<NavigationService>();

  SplashController()
      : _presenter = serviceLocator<SplashPresenter>(),
        super();

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter!.dispose();
    super.onDisposed();
  }

  SplashState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  void checkIfUserIsLoggedIn() async {
    print("Checking if user is logged In");
    _presenter!.checkLoginStatus(
      UseCaseObserver(
        () {},
        _handleSplashError,
        onNextFunc: (isLoggedIn) {
          if (isLoggedIn == true) {
            _handleSignInSuccess();
          } else {
            _navigateToSignInPage();
          }
        },
      ),
    );
  }

  _handleSplashError(error) {
    _navigateToSignInPage();
  }

  _navigateToSignInPage() {
    _navigationService!.navigateTo(
      NavigationService.signInRoute,
      shouldReplace: true,
    );
  }


  _handleSignInSuccess() {
    _presenter!.getUserData(
      UseCaseObserver(
        () {},
        _handleSplashError,
        onNextFunc: (UserEntity user) {
          if (user.runtimeType == StudentUserEntity) {
            _navigationService!.navigateTo(NavigationService.homepageStudent,
                shouldReplace: true);
          } else {
            _navigationService!.navigateTo(NavigationService.homepageInstructor,
                shouldReplace: true);
          }
        },
      ),
    );
  }
}

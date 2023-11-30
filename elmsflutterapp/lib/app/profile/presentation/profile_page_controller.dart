import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/injection_container.dart' as di;
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/presentation/observer.dart';
import '../../navigation_service.dart';
import 'profile_page_presenter.dart';
import 'profile_page_state_machine.dart';

class ProfilePageController extends Controller {
  final ProfilePagePresenter _presenter;
  final ProfilePageStateMachine _stateMachine = ProfilePageStateMachine();
  final NavigationService? _navigationService =
      di.serviceLocator<NavigationService>();
  ProfilePageController()
      : _presenter = di.serviceLocator<ProfilePagePresenter>(),
        super();

  String staffName = "";

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void getUserData() {
    _presenter.getUserData(UseCaseObserver(() {}, (error) {
      _stateMachine.onEvent(ProfilePageErrorEvent(error));
      refreshUI();
    }, onNextFunc: (UserEntity user) {
      staffName= user.name;
      _stateMachine.onEvent(ProfilePageInitializedEvent(staffName));
      refreshUI();
    }));
  }


  void signout() {
    _stateMachine.onEvent(SignoutClickedEvent());
    refreshUI();
    _presenter.signout(
      UseCaseObserver(_handleSignoutSuccess, (error){}),
    );
  }

  void resetPassword(String? _staffName, BuildContext context) {
    _stateMachine.onEvent(ResetPasswordClickedEvent());
    refreshUI();
    _presenter.resetPassword(
      UseCaseObserver(() => _handleResetPasswordSuccess(_staffName, context),
          _handleResetPasswordError),
    );
  }

  ProfilePageState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  void handleBackButtonClick() {
    _navigationService!.navigateBack();
  }

  _handleSignoutSuccess() async {
    _navigationService!.navigateBack();
    _navigationService!.navigateBack();
    _navigationService!
        .navigateTo(NavigationService.signInRoute, shouldReplace: true);
    await di.reset();
  }

  

  _handleResetPasswordSuccess(String? _staffName, BuildContext context) {
    String _successMsg = "Reset password link has been mailed to you";
    Fluttertoast.showToast(msg: _successMsg);
    _stateMachine.onEvent(ProfilePageInitializedEvent(staffName));
    refreshUI();
  }

  _handleResetPasswordError(error) {
    
  }

  // void navigateToHomeScreen() {
  //   _navigationService!.navigateTo(NavigationService.home, shouldReplace: true);
  // }
}

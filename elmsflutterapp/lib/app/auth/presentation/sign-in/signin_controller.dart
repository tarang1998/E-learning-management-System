import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/presentation/observer.dart';
import '../../../../injection_container.dart';
import '../../../navigation_service.dart';
import 'signin_presenter.dart';
import 'signin_state_machine.dart';

class SigninController extends Controller {
  final SigninPresenter? _presenter;
  final SignInStateMachine _stateMachine = new SignInStateMachine();
  final NavigationService? _navigationService =
      serviceLocator<NavigationService>();

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  bool? signInAsInstructor = false;

  SigninController()
      : _presenter = serviceLocator<SigninPresenter>(),
        emailTextController = TextEditingController(),
        passwordTextController = TextEditingController(),
        super();

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter!.dispose();
    super.onDisposed();
  }

  void signinWithEmailAndPassword() async {
    _stateMachine.onEvent(SignInClickedEvent());
    refreshUI();
    _presenter!.signIn(
        UseCaseObserver(() {}, (error) => _handleSignInError(error: error),
            onNextFunc: (UserEntity user) {
          _handleSignInSuccess(user);
        }),
        emailTextController.text.trim(),
        passwordTextController.text,
        signInAsInstructor);
  }

  SignInState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  _handleSignInSuccess(UserEntity user) {
    print('Login Success');
    if (user.runtimeType == StudentUserEntity) {
      _navigationService!
          .navigateTo(NavigationService.homepageStudent, shouldReplace: true);
    } else {
      _navigationService!.navigateTo(NavigationService.homepageInstructor,
          shouldReplace: true);
    }
  }

  _handleSignInError({required error}) {
    print("Error while signin");
    _stateMachine.onEvent(SignInErrorEvent());
    refreshUI();

    if (error.runtimeType == LoginInvalidEmailPasswordException) {
      Fluttertoast.showToast(
        msg: "Looks like you entered an incorrect email or password.",
      );
    } else if (error.runtimeType == LoginNetworkRequestFailedException) {
      Fluttertoast.showToast(
        msg: "Oops! Looks like you aren't connected to the internet.",
      );
    } else if (error.runtimeType == LoginTooManyRequestException) {
      Fluttertoast.showToast(
        msg:
            "You've had too many unsuccessful login attempts. Please try again in some time.",
      );
    } else if (error.runtimeType == StudentDataDoesNotExistException) {
      Fluttertoast.showToast(
        msg: "A student account with this email does not exist",
      );
    } else if (error.runtimeType == InstructorDataDoesNotExistException) {
      Fluttertoast.showToast(
        msg: "An instructor account with this email does not exist",
      );
    } else if (error.runtimeType == LoginException) {
      Fluttertoast.showToast(
        msg: "There was an error while signing in.",
      );
    } else {
      Fluttertoast.showToast(
        msg: "There was an error while signing in.",
      );
    }
  }

  void passwordResetRequested(
      {required String email, required BuildContext context}) {
    _stateMachine.onEvent(new PasswordResetRequestedEvent());
    refreshUI();
    _presenter!.forgotPassword(
      new UseCaseObserver(
          () => _handleForgotPasswordSuccess(context),
          (error) =>
              _handleForgotPasswordError(error: error, context: context)),
      email,
    );
  }

  _handleForgotPasswordSuccess(BuildContext context) {
    _navigationService!.navigateBack();
    Fluttertoast.showToast(
        msg: "Reset password link has been sent to your email");
    _stateMachine.onEvent(SignInInitEvent());
    refreshUI();
  }

  _handleForgotPasswordError(
      {required Exception error, required BuildContext context}) {
    print("Error in forgot password ");

    _stateMachine.onEvent(new SignInErrorEvent());
    refreshUI();
    if (error.runtimeType == ForgotPasswordInvalidEmailPasswordException) {
      Fluttertoast.showToast(
        msg: "Looks like you entered an incorrect email",
      );
    } else if (error.runtimeType ==
        ForgotPasswordNetworkRequestFailedException) {
      Fluttertoast.showToast(
        msg: "Oops! Looks like you aren't connected to the internet.",
      );
    } else if (error.runtimeType == ForgotPasswordTooManyRequestException) {
      Fluttertoast.showToast(
          msg:
              "You've had too many unsuccessful reset password attempts. Please try again in some time.");
    } else if (error.runtimeType == ForgotPasswordException) {
      Fluttertoast.showToast(
        msg: "An unexpected error occured. Please try again in some time.",
      );
    } else {
      Fluttertoast.showToast(
        msg: "An unexpected error occured. Please try again in some time.",
      );
    }
  }

  void forgotPasswordClicked() {
    _stateMachine.onEvent(ForgotPasswordClickedEvent());
    refreshUI();
  }

  void refreshPage() {
    refreshUI();
  }

  void naviagateToRegisterPage(){
    _navigationService!.navigateTo(NavigationService.registerRoute,shouldReplace: true);
  }
}

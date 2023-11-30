import 'package:elmsflutterapp/app/auth/domain/usecases/register_student_user_usecase.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'registration_presenter.dart';
import 'registration_state_machine.dart';

class RegistrationPageController extends Controller {
  final RegistrationPagePresenter _presenter;
  final RegistrationPageStateMachine _stateMachine =
      RegistrationPageStateMachine();
  final NavigationService? navigationService =
      serviceLocator<NavigationService>();
  RegistrationPageController()
      : _presenter = serviceLocator<RegistrationPagePresenter>(),
        super();

  TextEditingController studentName = TextEditingController();
  TextEditingController studentEmail = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmedPassword = true;

  @override
  void initListeners() {
    studentEmail.text = '';
    studentName.text = '';
    passwordText.text = '';
    confirmPasswordText.text = '';
  }

  @override
  onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  RegistrationState? getCurrentState() {
    return _stateMachine.getCurrentState();
  }

  void submitForRegistration() {
    _stateMachine.onEvent(RegistrationPageLoadingEvent());
    refreshUI();
    _presenter.registerStudentUser(
        UseCaseObserver(() {
          Fluttertoast.showToast(
                msg: "User created successfully");
          navigationService!.navigateTo(NavigationService.signInRoute,shouldReplace: true);
        }, (error) {
          if (error.runtimeType == RegisterWeakPasswordException) {
            Fluttertoast.showToast(
                msg: "Please try registering using a stronger password");
          } else if (error.runtimeType == RegisterEmailAlreadyInUseException) {
            Fluttertoast.showToast(msg: "This email is already in use ");
          } else {
            _stateMachine.onEvent(RegistrationPageErrorEvent());
            refreshUI();
          }
          
        }),
        password: passwordText.text,
        userEmail: studentEmail.text,
        userName: studentName.text);
  }

  bool checkIfAllFieldsAreFilled() {
    if (passwordText.text.isEmpty || confirmPasswordText.text.isEmpty)
      return false;
    if (studentEmail.text.isEmpty || studentName.text.isEmpty) return false;
    return true;
  }

  bool checkIfPasswordsMatch() {
    if (passwordText.text != confirmPasswordText.text) return false;
    return true;
  }

  void navigateToLoginPage(){
    navigationService!.navigateTo(NavigationService.signInRoute,shouldReplace: true);
  }
}

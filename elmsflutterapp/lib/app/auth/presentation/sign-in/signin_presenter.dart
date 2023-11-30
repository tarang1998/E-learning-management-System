// Import necessary packages and files
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/signin_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../core/presentation/observer.dart';

// Define the SigninPresenter class
class SigninPresenter extends Presenter {
  final SignInUsecase? _signInUsecase;
  final ForgotPasswordUsecase? _forgotPasswordUsecase;

  // Constructor for the SigninPresenter
  SigninPresenter(
    this._signInUsecase,
    this._forgotPasswordUsecase,
  );

  @override
  void dispose() {
    _signInUsecase!.dispose();
    _forgotPasswordUsecase!.dispose();
  }

  // Function to initiate the sign-in use case
  void signIn(UseCaseObserver observer, email, password, isUserAnInstructor) {
    _signInUsecase!.execute(observer, SignInParams(email, password, isUserAnInstructor));
  }

  // Function to initiate the forgot password use case
  void forgotPassword(UseCaseObserver observer, email) {
    _forgotPasswordUsecase!
        .execute(observer, ForgotPasswordUsecaseParams(email));
  }
}

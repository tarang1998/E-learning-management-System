import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../core/presentation/observer.dart';

class SigninPresenter extends Presenter {
  final AuthenticateWithEmailAndPasswordUseCase? authenticateWithEmailAndPasswordUsecase;
  final ForgotPasswordUsecase? _forgotPasswordUsecase;

  SigninPresenter(
    this.authenticateWithEmailAndPasswordUsecase,
    this._forgotPasswordUsecase,
  );

  @override
  void dispose() {
    authenticateWithEmailAndPasswordUsecase!.dispose();
    _forgotPasswordUsecase!.dispose();
  }

  void loginWithEmailAndPassword(UseCaseObserver observer, email, password,isUserAnInstructor){
    authenticateWithEmailAndPasswordUsecase!.execute(observer,  AuthenticateWithEmailAndPasswordParams(email, password,isUserAnInstructor));
  }

  void forgotPassword(UseCaseObserver observer, email) {
    _forgotPasswordUsecase!
        .execute(observer, ForgotPasswordUsecaseParams(email));
  }
}

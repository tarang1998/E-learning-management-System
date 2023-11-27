import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/signin_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../core/presentation/observer.dart';

class SigninPresenter extends Presenter {
  final SignInUsecase? _signInUsecase;
  final ForgotPasswordUsecase? _forgotPasswordUsecase;

  SigninPresenter(
    this._signInUsecase,
    this._forgotPasswordUsecase,
    
  );

  @override
  void dispose() {
    _signInUsecase!.dispose();
    _forgotPasswordUsecase!.dispose();
  }

  void signIn(UseCaseObserver observer, email, password,isUserAnInstructor){
    _signInUsecase!.execute(observer,  SignInParams(email, password,isUserAnInstructor));
  }

  void forgotPassword(UseCaseObserver observer, email) {
    _forgotPasswordUsecase!
        .execute(observer, ForgotPasswordUsecaseParams(email));
  }
}

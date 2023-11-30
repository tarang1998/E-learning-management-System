import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/reset_passsword_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/signout_usecase.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../core/presentation/observer.dart';

class ProfilePagePresenter extends Presenter {
  final SignoutUsecase _signoutUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  final GetUserDataUsecase _getUserDataUsecase;

  ProfilePagePresenter(this._signoutUsecase, this._resetPasswordUsecase,
      this._getUserDataUsecase);

  @override
  void dispose() {
    _signoutUsecase.dispose();
    _getUserDataUsecase.dispose();
    _resetPasswordUsecase.dispose();
  }

  void signout(UseCaseObserver observer) {
    _signoutUsecase.execute(observer);
  }

  void getUserData(UseCaseObserver observer) {
    _getUserDataUsecase.execute(observer,GetUserDataUsecaseParams(UserConfig.instance!.uid,UserConfig.instance!.isUserAnInstructor));
  }

  void resetPassword(UseCaseObserver observer) {
    _resetPasswordUsecase.execute(observer);
  }
}

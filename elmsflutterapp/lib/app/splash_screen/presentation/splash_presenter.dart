import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../core/presentation/observer.dart';
import '../../auth/domain/usecases/check_login_status_usecase.dart';

class SplashPresenter extends Presenter {
  final CheckLoginStatusUsecase? _checkLoginStatusUsecase;
  final GetUserDataUsecase? _getUserDataUsecase;

  SplashPresenter(
    this._checkLoginStatusUsecase,
    this._getUserDataUsecase,
  );

  @override
  void dispose() {
    _checkLoginStatusUsecase!.dispose();
    _getUserDataUsecase!.dispose();
  }

  void checkLoginStatus(UseCaseObserver observer) {
    _checkLoginStatusUsecase!.execute(observer);
  }

  void getUserData(
    UseCaseObserver observer,
  ) {
    _getUserDataUsecase!.execute(
        observer,
        GetUserDataUsecaseParams(
            UserConfig.instance!.uid, UserConfig.instance!.isUserAnInstructor));
  }
}

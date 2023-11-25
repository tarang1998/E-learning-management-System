import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../core/presentation/observer.dart';
import '../../auth/domain/usecases/check_login_status_usecase.dart';

class SplashPresenter extends Presenter {
  final CheckLoginStatusUsecase? _checkLoginStatusUsecase;
  // final GetStudentDataUsecase? _getStudentDataUsecase;

  SplashPresenter(
    this._checkLoginStatusUsecase,
    // this._getStudentDataUsecase,
  );

  @override
  void dispose() {
    _checkLoginStatusUsecase!.dispose();
    // _getStudentDataUsecase!.dispose();
  }

  void checkLoginStatus(UseCaseObserver observer) {
    _checkLoginStatusUsecase!.execute(observer);
  }

  void fetchStudentDetails(UseCaseObserver observer) {
    // _getStudentDataUsecase!.execute(observer);
  }

  
}

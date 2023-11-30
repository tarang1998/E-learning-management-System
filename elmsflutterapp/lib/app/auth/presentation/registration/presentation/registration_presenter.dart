import 'package:elmsflutterapp/app/auth/domain/usecases/register_student_user_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RegistrationPagePresenter extends Presenter {
  final RegisterStudentUserUsecase _registerStudentUserUsecase;

  RegistrationPagePresenter(
    this._registerStudentUserUsecase,
  );

  @override
  dispose() {
    _registerStudentUserUsecase.dispose();
  }

  void registerStudentUser(UseCaseObserver observer,
      {required String userName,
      required String userEmail,
      required String password}) {
    _registerStudentUserUsecase.execute(
        observer,
        RegisterStudentUserUsecaseParams(
            password: password, userEmail: userEmail, userName: userName));
  }
}

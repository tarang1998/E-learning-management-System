import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePageStudentPresenter extends Presenter {
  final GetUserDataUsecase? _getUserDataUsecase;

  HomePageStudentPresenter(
    this._getUserDataUsecase,
  );

  @override
  void dispose() {
    _getUserDataUsecase!.dispose();
  }

  void getUserData({required UseCaseObserver observer}) {
    _getUserDataUsecase!.execute(
        observer,
        GetUserDataUsecaseParams(
            UserConfig.instance!.uid, UserConfig.instance!.isUserAnInstructor));
  }
}

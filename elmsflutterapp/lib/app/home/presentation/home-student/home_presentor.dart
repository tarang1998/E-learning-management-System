import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePageStudentPresenter extends Presenter {
  // Instance of GetUserDataUsecase for fetching user data.
  final GetUserDataUsecase? _getUserDataUsecase;

  // Constructor to initialize the presenter with the use case.
  HomePageStudentPresenter(
    this._getUserDataUsecase,
  );

  @override
  void dispose() {
    // Dispose of the use case when the presenter is disposed.
    _getUserDataUsecase!.dispose();
  }

  // Method to initiate the execution of the GetUserDataUsecase.
  void getUserData({required UseCaseObserver observer}) {
    _getUserDataUsecase!.execute(
        observer,
        GetUserDataUsecaseParams(
            UserConfig.instance!.uid, UserConfig.instance!.isUserAnInstructor));
  }
}

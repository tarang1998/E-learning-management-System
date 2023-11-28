import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../../core/presentation/observer.dart';

class HomePageInstructorPresenter extends Presenter {
  final GetUserDataUsecase? _getUserDataUsecase;

  HomePageInstructorPresenter(
    this._getUserDataUsecase,
  );

  @override
  void dispose() {
    _getUserDataUsecase!.dispose();
  }

  void getInstructorData({required UseCaseObserver observer}) {
    _getUserDataUsecase!.execute(
        observer,
        GetUserDataUsecaseParams(
            UserConfig.instance!.uid, UserConfig.instance!.isUserAnInstructor));
  }
}

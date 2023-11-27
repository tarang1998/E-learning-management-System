import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../core/presentation/observer.dart';

class HomePagePresenter extends Presenter {
  // final GetStudentDataUsecase? _getStudentDataUsecase;
  // final GetDeviceInformationUsecase? _getDeviceInformationUsecase;

  HomePagePresenter(
    // this._getStudentDataUsecase,
    // this._getDeviceInformationUsecase,
  );

  @override
  void dispose() {
    // _getStudentDataUsecase!.dispose();
    // _getDeviceInformationUsecase!.dispose();
  }

  // void getStudentData({required UseCaseObserver observer}) {
  //   _getStudentDataUsecase!.execute(observer);
  // }

  // void getDeviceInformation(UseCaseObserver observer) {
  //   _getDeviceInformationUsecase!.execute(observer);
  // }
}

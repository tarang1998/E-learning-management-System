// Importing necessary packages and classes
import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Importing core presentation classes
import '../../../../../../core/presentation/observer.dart';

// Presenter class for managing the business logic of the instructor's home page
class HomePageInstructorPresenter extends Presenter {
  // Use case for getting user data
  final GetUserDataUsecase? _getUserDataUsecase;

  // Constructor to initialize dependencies
  HomePageInstructorPresenter(
    this._getUserDataUsecase,
  );

  // Overriding method to dispose of resources
  @override
  void dispose() {
    _getUserDataUsecase!.dispose();
  }

  // Method to get instructor data and notify observers
  void getInstructorData({required UseCaseObserver observer}) {
    // Executing the use case to get user data based on the user's role
    _getUserDataUsecase!.execute(
        observer,
        GetUserDataUsecaseParams(
            UserConfig.instance!.uid, UserConfig.instance!.isUserAnInstructor));
  }
}

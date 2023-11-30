// Importing necessary Dart libraries and packages.
import 'dart:async';

// Importing user-related entities and use cases.
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

// Importing a custom observer for use cases.
import '../../../../core/presentation/observer.dart';

// Importing the AuthenticateWithEmailAndPasswordUseCase for authentication.
import 'authenticate_with_email_password_usecase.dart';

// Defining a use case for handling user sign-in.
class SignInUsecase extends CompletableUseCase<SignInParams> {
  final AuthenticateWithEmailAndPasswordUseCase _authenticateWithEmailAndPasswordUseCase;
  final GetUserDataUsecase _getUserDataUsecase;

  // Constructor that takes instances of necessary use cases.
  SignInUsecase(this._authenticateWithEmailAndPasswordUseCase, this._getUserDataUsecase);

  // Implementation of the sign-in use case logic.
  @override
  Future<Stream<UserEntity>> buildUseCaseStream(SignInParams? params) async {
    // Creating a stream controller to manage the output stream.
    final StreamController<UserEntity> streamController = StreamController();

    // Executing the authentication use case with the provided parameters.
    _authenticateWithEmailAndPasswordUseCase.execute(
      // Use case observer for the authentication process.
      UseCaseObserver(
        // Success callback for authentication.
        () {},
        // Error callback for authentication.
        (error) {
          streamController.addError(error);
        },
        // Callback for successful authentication.
        onNextFunc: (String userId) {
          // Executing the get user data use case with the obtained user ID.
          _getUserDataUsecase.execute(
            // Use case observer for fetching user data.
            UseCaseObserver(
              // Success callback for fetching user data.
              () {},
              // Error callback for fetching user data.
              (error) {
                streamController.addError(error);
              },
              // Callback for successful user data retrieval.
              onNextFunc: (UserEntity user) {
                // Adding the user entity to the output stream.
                streamController.add(user);
              },
            ),
            GetUserDataUsecaseParams(userId, params!.isUserAnInstructor),
          );
        },
      ),
      // Parameters for authentication.
      AuthenticateWithEmailAndPasswordParams(
        params!.email,
        params.password,
        params.isUserAnInstructor,
      ),
    );

    // Returning the stream from the stream controller.
    return streamController.stream;
  }
}

// Parameters class for the SignInUsecase.
class SignInParams {
  final String email;
  final String password;
  final bool isUserAnInstructor;

  // Constructor for initializing sign-in parameters.
  SignInParams(this.email, this.password, this.isUserAnInstructor);
}

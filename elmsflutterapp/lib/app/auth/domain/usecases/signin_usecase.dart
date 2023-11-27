import 'dart:async';

import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../core/presentation/observer.dart';
import 'authenticate_with_email_password_usecase.dart';

class SignInUsecase extends CompletableUseCase<SignInParams> {
  final AuthenticateWithEmailAndPasswordUseCase
      _authenticateWithEmailAndPasswordUseCase;
  final GetUserDataUsecase _getUserDataUsecase;

  SignInUsecase(
      this._authenticateWithEmailAndPasswordUseCase, this._getUserDataUsecase);

  @override
  Future<Stream<UserEntity>> buildUseCaseStream(SignInParams? params) async {
    final StreamController<UserEntity> streamController = StreamController();

    _authenticateWithEmailAndPasswordUseCase.execute(
      //Usecase observer for Authentication
      UseCaseObserver(
          //Success callback for Authentication
          () {},
          //error callback for Authentication
          (error) {
        streamController.addError(error);
      }, onNextFunc: (String userId) {
        _getUserDataUsecase.execute(
            //Usecase observer for fetching user data
            UseCaseObserver(() {}, (error) {
          streamController.addError(error);
        }, onNextFunc: (UserEntity user) {
          streamController.add(user);
        }),GetUserDataUsecaseParams(userId, params!.isUserAnInstructor));
      }),
      AuthenticateWithEmailAndPasswordParams(
          params!.email, params.password, params.isUserAnInstructor),
    );

    return streamController.stream;
  }
}

class SignInParams {
  final String email;
  final String password;
  final bool isUserAnInstructor;

  SignInParams(this.email, this.password, this.isUserAnInstructor);
}

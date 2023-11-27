import '../../../core/presentation/state_machine.dart';

class SignInStateMachine extends StateMachine<SignInState?, SignInEvent> {
  SignInStateMachine() : super(new SignInInitState());

  @override
  SignInState? getStateOnEvent(SignInEvent event) {
    final eventType = event.runtimeType;
    SignInState? newState = getCurrentState();
    switch (eventType) {
      case SignInInitEvent:
        newState = SignInInitState();
        break;

      case SignInClickedEvent:
        newState = SignInLoadingState();
        break;

      case ForgotPasswordClickedEvent:
        newState = SignInInitState();
        break;

      case PasswordResetRequestedEvent:
        newState = new SignInLoadingState();
        break;

      case SignInErrorEvent:
        newState = SignInInitState();
        break;
    }
    return newState;
  }
}

abstract class SignInEvent {}

class SignInInitEvent extends SignInEvent {}

class SignInClickedEvent extends SignInEvent {}

class ForgotPasswordClickedEvent extends SignInEvent {}

class PasswordResetRequestedEvent extends SignInEvent {}

class SignInErrorEvent extends SignInEvent {}

abstract class SignInState {}

class SignInInitState extends SignInState {}

class SignInLoadingState extends SignInState {}

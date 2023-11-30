// Import necessary packages and files
import '../../../../core/presentation/state_machine.dart';

// Define the SignInStateMachine class, extending from StateMachine
class SignInStateMachine extends StateMachine<SignInState?, SignInEvent> {
  // Constructor initializing the state machine with SignInInitState
  SignInStateMachine() : super(new SignInInitState());

  // Override method to determine the next state based on the event
  @override
  SignInState? getStateOnEvent(SignInEvent event) {
    final eventType = event.runtimeType;
    SignInState? newState = getCurrentState();

    // Switch statement to handle different event types
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

// Define abstract class SignInEvent
abstract class SignInEvent {}

// Define specific events that extend SignInEvent
class SignInInitEvent extends SignInEvent {}
class SignInClickedEvent extends SignInEvent {}
class ForgotPasswordClickedEvent extends SignInEvent {}
class PasswordResetRequestedEvent extends SignInEvent {}
class SignInErrorEvent extends SignInEvent {}

// Define abstract class SignInState
abstract class SignInState {}

// Define specific states that extend SignInState
class SignInInitState extends SignInState {}
class SignInLoadingState extends SignInState {}

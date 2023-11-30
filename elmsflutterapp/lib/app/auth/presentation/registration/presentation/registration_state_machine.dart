import 'package:elmsflutterapp/core/presentation/state_machine.dart';

class RegistrationPageStateMachine
    extends StateMachine<RegistrationState?, RegistrationEvent> {
  RegistrationPageStateMachine() : super(RegistrationPageInitializedState());

  @override
  RegistrationState? getStateOnEvent(RegistrationEvent event) {
    final eventType = event.runtimeType;
    RegistrationState? newState = getCurrentState();
    switch (eventType) {
      case RegistrationPageLoadingEvent:
        newState = RegistrationPageLoadingState();
        break;

      case RegistrationPageInitializationEvent:
        newState = RegistrationPageInitializedState();
        break;
    }
    return newState;
  }
}

class RegistrationState {}

class RegistrationPageInitializedState extends RegistrationState {
  RegistrationPageInitializedState();
}

class RegistrationPageLoadingState extends RegistrationState {
  RegistrationPageLoadingState();
}

class RegistrationPageErrorState extends RegistrationState {}

class RegistrationEvent {}

class RegistrationPageInitializationEvent extends RegistrationEvent {}

class RegistrationPageInitializedEvent extends RegistrationEvent {
  RegistrationPageInitializedEvent();
}

class RegistrationPageErrorEvent extends RegistrationEvent {}

class RegistrationPageLoadingEvent extends RegistrationEvent {}

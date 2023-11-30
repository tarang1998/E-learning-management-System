import '../../../core/presentation/state_machine.dart';

class ProfilePageStateMachine
    extends StateMachine<ProfilePageState?, ProfilePageEvent> {
  ProfilePageStateMachine() : super(ProfilePageInitState());

  @override
  ProfilePageState? getStateOnEvent(ProfilePageEvent event) {
    final eventType = event.runtimeType;
    ProfilePageState? newState = getCurrentState();
    switch (eventType) {
      case ProfilePageInitializedEvent:
        ProfilePageInitializedEvent successEvent =
            event as ProfilePageInitializedEvent;
        newState = ProfilePageInitializedState(successEvent.staffName);
        break;

      case SignoutClickedEvent:
      case ResetPasswordClickedEvent:
        newState = ProfilePageLoadingState();
        break;

      case SignoutErrorEvent:
      case ResetPasswordErrorEvent:
        ProfilePageErrorEvent errorEvent = event as ProfilePageErrorEvent;
        newState = ProfilePageErrorState(errorEvent.error.toString());
        break;
    }
    return newState;
  }
}

abstract class ProfilePageEvent {}

class ProfilePageInitEvent extends ProfilePageEvent {}

class ProfilePageInitializedEvent extends ProfilePageEvent {
  final String? staffName;

  ProfilePageInitializedEvent(this.staffName);
}

class SignoutClickedEvent extends ProfilePageEvent {}

class ProfilePageErrorEvent extends ProfilePageEvent {
  final Exception error;
  ProfilePageErrorEvent(this.error);
}

class SignoutErrorEvent extends ProfilePageErrorEvent {
  SignoutErrorEvent(Exception error) : super(error);
}

class ResetPasswordClickedEvent extends ProfilePageEvent {}

class ResetPasswordErrorEvent extends ProfilePageErrorEvent {
  ResetPasswordErrorEvent(Exception error) : super(error);
}

abstract class ProfilePageState {}

class ProfilePageInitState implements ProfilePageState {}

class ProfilePageInitializedState extends ProfilePageState {
  final String? staffName;

  ProfilePageInitializedState(this.staffName);
}

class ProfilePageLoadingState implements ProfilePageState {}

class ProfilePageErrorState implements ProfilePageState {
  final String errorMessage;

  ProfilePageErrorState(this.errorMessage);
}

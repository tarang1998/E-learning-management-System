import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import '../../../../../../core/presentation/state_machine.dart';

// State machine for managing the state of the student's home page.
class HomePageStudentStateMachine
    extends StateMachine<HomePageStudentState?, HomePageStudentEvent> {
  // Constructor initializing the state machine with an initial loading state.
  HomePageStudentStateMachine() : super(HomePageStudentLoadingState());

  @override
  HomePageStudentState? getStateOnEvent(HomePageStudentEvent event) {
    final eventType = event.runtimeType;
    HomePageStudentState? newState = getCurrentState();
    switch (eventType) {
      // Transition to the initialized state when the home page is initialized.
      case HomePageStudentInitializedEvent:
        HomePageStudentInitializedEvent initEvent =
            event as HomePageStudentInitializedEvent;
        newState = HomePageStudentInitState(initEvent.studentData, 0);
        break;

      // Transition to the initialized state when a tab is clicked.
      case HomePageStudentTabClickEvent:
        HomePageStudentTabClickEvent tabClickEvent =
            event as HomePageStudentTabClickEvent;
        newState = HomePageStudentInitState(
            tabClickEvent.studentEntity, tabClickEvent.page);
        break;

      // Transition to the error state when an error event occurs.
      case HomePageStudentErrorEvent:
        HomePageStudentErrorEvent errorEvent =
            event as HomePageStudentErrorEvent;
        newState = HomePageStudentErrorState(errorEvent.error.toString());
        break;
    }
    return newState;
  }
}

// Events that can trigger state transitions in the home page state machine.
abstract class HomePageStudentEvent {}

// Event indicating an error during the student's home page operation.
class HomePageStudentErrorEvent extends HomePageStudentEvent {
  final Exception error;

  HomePageStudentErrorEvent(this.error);
}

// Event indicating the successful initialization of the student's home page.
class HomePageStudentInitializedEvent extends HomePageStudentEvent {
  final StudentUserEntity studentData;

  HomePageStudentInitializedEvent(
    this.studentData,
  );
}

// Event indicating a tab click in the student's home page.
class HomePageStudentTabClickEvent extends HomePageStudentEvent {
  final StudentUserEntity studentEntity;
  final int page;

  HomePageStudentTabClickEvent(this.studentEntity, this.page);
}

// States representing different scenarios in the student's home page.
abstract class HomePageStudentState {}

// State representing the initial state of loading for the student's home page.
class HomePageStudentLoadingState implements HomePageStudentState {}

// State representing the initialized state of the student's home page.
class HomePageStudentInitState implements HomePageStudentState {
  final StudentUserEntity studentData;
  final int page;

  HomePageStudentInitState(this.studentData, this.page);
}

// State representing an error state in the student's home page.
class HomePageStudentErrorState implements HomePageStudentState {
  final String errorMessage;

  HomePageStudentErrorState(this.errorMessage);
}

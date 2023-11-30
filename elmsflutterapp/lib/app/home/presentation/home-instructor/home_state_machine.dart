// Importing necessary packages and classes
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';

// Importing core presentation state machine class
import '../../../../../../core/presentation/state_machine.dart';

// State machine class for managing the state of the instructor's home page
class HomePageInstructorStateMachine
    extends StateMachine<HomePageInstructorState?, HomePageInstructorEvent> {
  // Constructor to initialize the state machine with an initial state
  HomePageInstructorStateMachine()
      : super(HomePageInstructorInitializationState());

  // Overriding method to determine the next state based on the received event
  @override
  HomePageInstructorState? getStateOnEvent(HomePageInstructorEvent event) {
    // Extracting the type of the received event
    final eventType = event.runtimeType;
    // Initializing a variable to store the new state
    HomePageInstructorState? newState = getCurrentState();

    // Switching based on the type of the received event
    switch (eventType) {
      // Handling the event when the instructor's home page is initialized
      case HomePageInstructorInitializedEvent:
        HomePageInstructorInitializedEvent initEvent =
            event as HomePageInstructorInitializedEvent;
        newState = HomePageInstructorInitState(initEvent.instructorData, 0);
        break;

      // Handling the event when a tab is clicked on the instructor's home page
      case HomePageInstructorTabClickEvent:
        HomePageInstructorTabClickEvent tabClickEvent =
            event as HomePageInstructorTabClickEvent;
        newState = HomePageInstructorInitState(
            tabClickEvent.instructorData, tabClickEvent.page);
        break;

      // Handling the event when an error occurs on the instructor's home page
      case HomePageInstructorErrorEvent:
        HomePageInstructorErrorEvent errorEvent =
            event as HomePageInstructorErrorEvent;
        newState = HomePageInstructorErrorState(errorEvent.error.toString());
        break;
    }
    return newState;
  }
}

// Abstract class representing events in the instructor's home page
abstract class HomePageInstructorEvent {}

// Event class representing an error event on the instructor's home page
class HomePageInstructorErrorEvent extends HomePageInstructorEvent {
  final Exception error;

  HomePageInstructorErrorEvent(this.error);
}

// Event class representing the initialization of the instructor's home page
class HomePageInstructorInitializedEvent extends HomePageInstructorEvent {
  final InstructorUserEntity instructorData;
  final int page;

  HomePageInstructorInitializedEvent(this.instructorData, this.page);
}

// Event class representing a tab click on the instructor's home page
class HomePageInstructorTabClickEvent extends HomePageInstructorEvent {
  final InstructorUserEntity instructorData;
  final int page;

  HomePageInstructorTabClickEvent(this.instructorData, this.page);
}

// Abstract class representing states in the instructor's home page
abstract class HomePageInstructorState {}

// Initial state class representing the initialization of the instructor's home page
class HomePageInstructorInitializationState
    implements HomePageInstructorState {}

// State class representing the initialized state of the instructor's home page
class HomePageInstructorInitState implements HomePageInstructorState {
  InstructorUserEntity instructorData;
  final int page;

  HomePageInstructorInitState(this.instructorData, this.page);
}

// State class representing the loading state of the instructor's home page
class HomePageInstructorLoadingState implements HomePageInstructorState {}

// State class representing the error state of the instructor's home page
class HomePageInstructorErrorState implements HomePageInstructorState {
  final String errorMessage;

  HomePageInstructorErrorState(this.errorMessage);
}

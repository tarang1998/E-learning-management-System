// Importing necessary packages and classes
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

// Importing the state machine class from the core presentation package
import '../../../../../core/presentation/state_machine.dart';

// Class definition for the DashboardPageStateMachine
class DashboardPageStateMachine
    extends StateMachine<DashboardPageState?, DashboardPageEvent> {
  // Constructor initializing the state machine with the initial state
  DashboardPageStateMachine()
      : super(DashboardPageInitializationState());

  // Override method to determine the new state based on the received event
  @override
  DashboardPageState? getStateOnEvent(DashboardPageEvent event) {
    // Identifying the type of the received event
    final eventType = event.runtimeType;
    
    // Initializing the new state with the current state
    DashboardPageState? newState = getCurrentState();

    // Switching based on the event type to determine the new state
    switch (eventType) {
      case DashboardPageInitializedEvent:
        // Casting the event to the appropriate type
        DashboardPageInitializedEvent initializedEvent =
            event as DashboardPageInitializedEvent;
        
        // Updating the state to reflect the initialization with courses
        newState = DashboardPageInitializedState(
            courses: initializedEvent.courses);
        break;

      case DashboardPageErrorEvent:
        // Updating the state to reflect an error
        newState = DashboardPageErrorState();
        break;

      case DashboardPageRefreshEvent:
        // Updating the state to reflect a refresh or reset
        newState = DashboardPageInitializationState();
        break;
    }

    return newState;
  }
}

// Abstract class for DashboardPageEvent
abstract class DashboardPageEvent {}

// Concrete events extending DashboardPageEvent
class DashboardPageLoadingEvent extends DashboardPageEvent {}

class DashboardPageRefreshEvent extends DashboardPageEvent {}

class DashboardPageInitializedEvent extends DashboardPageEvent {
  // List of CourseEntity representing the initialized courses
  List<CourseEntity> courses;

  // Constructor to initialize the event with courses
  DashboardPageInitializedEvent({
    required this.courses,
  });
}

class DashboardPageErrorEvent extends DashboardPageEvent {}

// Abstract class for DashboardPageState
abstract class DashboardPageState {}

// Concrete states extending DashboardPageState
class DashboardPageInitializationState
    implements DashboardPageState {}

class DashboardPageInitializedState implements DashboardPageState {
  // List of CourseEntity representing the initialized courses
  List<CourseEntity> courses;

  // Constructor to initialize the state with courses
  DashboardPageInitializedState({
    required this.courses,
  });
}

class DashboardPageErrorState implements DashboardPageState {}

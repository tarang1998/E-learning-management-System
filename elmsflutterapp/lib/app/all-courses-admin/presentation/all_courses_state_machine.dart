// Import statement for the 'CourseEntity' class
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

// Import statement for the custom StateMachine class
import '../../../../../core/presentation/state_machine.dart';

// Class definition for the AllCoursesPageStateMachine, extending the StateMachine class
class AllCoursesPageStateMachine
    extends StateMachine<AllCoursesPageState?, AllCoursesPageEvent> {
  // Constructor initializing the state machine with an initial state
  AllCoursesPageStateMachine() : super(AllCoursesPageInitializationState());

  // Method to determine the next state based on the incoming event
  @override
  AllCoursesPageState? getStateOnEvent(AllCoursesPageEvent event) {
    // Identify the type of the incoming event
    final eventType = event.runtimeType;
    // Initialize the new state with the current state
    AllCoursesPageState? newState = getCurrentState();

    // Switch statement to handle different event types
    switch (eventType) {
      case AllCoursesPageInitializedEvent:
        // If the event is of type 'AllCoursesPageInitializedEvent', update the state accordingly
        AllCoursesPageInitializedEvent initializedEvent =
            event as AllCoursesPageInitializedEvent;
        newState =
            AllCoursesPageInitializedState(courses: initializedEvent.courses);
        break;

      case AllCoursesPageErrorEvent:
        // If the event is of type 'AllCoursesPageErrorEvent', update the state to indicate an error
        newState = AllCoursesPageErrorState();
        break;

      case AllCoursesPageRefreshEvent:
        // If the event is of type 'AllCoursesPageRefreshEvent', set the state to the initialization state
        newState = AllCoursesPageInitializationState();
        break;

      case AllCoursesPageLoadingEvent:
        // If the event is of type 'AllCoursesPageLoadingEvent', set the state to indicate loading
        newState = AllCoursesPageLoadingState();
        break;
    }
    return newState;
  }
}

// Abstract class representing different events for the 'All Courses' page
abstract class AllCoursesPageEvent {}

// Class representing the event of loading courses
class AllCoursesPageLoadingEvent extends AllCoursesPageEvent {}

// Class representing the event of refreshing the 'All Courses' page
class AllCoursesPageRefreshEvent extends AllCoursesPageEvent {}

// Class representing the event of the 'All Courses' page being initialized with a list of courses
class AllCoursesPageInitializedEvent extends AllCoursesPageEvent {
  List<CourseEntity> courses;

  AllCoursesPageInitializedEvent({
    required this.courses,
  });
}

// Class representing the event of an error occurring on the 'All Courses' page
class AllCoursesPageErrorEvent extends AllCoursesPageEvent {}

// Abstract class representing different states for the 'All Courses' page
abstract class AllCoursesPageState {}

// Class representing the initial state of the 'All Courses' page
class AllCoursesPageInitializationState implements AllCoursesPageState {}

// Class representing the state of the 'All Courses' page being in a loading state
class AllCoursesPageLoadingState implements AllCoursesPageState {}

// Class representing the state of the 'All Courses' page being initialized with a list of courses
class AllCoursesPageInitializedState implements AllCoursesPageState {
  List<CourseEntity> courses;

  AllCoursesPageInitializedState({
    required this.courses,
  });
}

// Class representing the state of an error occurring on the 'All Courses' page
class AllCoursesPageErrorState implements AllCoursesPageState {}

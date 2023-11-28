import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

import '../../../../../core/presentation/state_machine.dart';

class InstructorCoursesPageStateMachine
    extends StateMachine<InstructorCoursesPageState?, InstructorCoursesPageEvent> {
  InstructorCoursesPageStateMachine()
      : super(InstructorCoursesPageInitializationState());

  @override
  InstructorCoursesPageState? getStateOnEvent(InstructorCoursesPageEvent event) {
    final eventType = event.runtimeType;
    InstructorCoursesPageState? newState = getCurrentState();
    switch (eventType) {
      case InstructorCoursesPageInitializedEvent:
        InstructorCoursesPageInitializedEvent initializedEvent =
            event as InstructorCoursesPageInitializedEvent;
        newState = InstructorCoursesPageInitializedState(
            courses: initializedEvent.courses);
        break;

      case InstructorCoursesPageErrorEvent:
        newState = InstructorCoursesPageErrorState();
        break;

      case InstructorCoursesPageRefreshEvent:
        newState = InstructorCoursesPageInitializationState();
        break;
    }
    return newState;
  }
}

abstract class InstructorCoursesPageEvent {}

class InstructorCoursesPageLoadingEvent extends InstructorCoursesPageEvent {}

class InstructorCoursesPageRefreshEvent extends InstructorCoursesPageEvent{}

class InstructorCoursesPageInitializedEvent extends InstructorCoursesPageEvent {
  List<CourseEntity> courses;

  InstructorCoursesPageInitializedEvent({
    required this.courses,
  });
}

class InstructorCoursesPageErrorEvent extends InstructorCoursesPageEvent {}

abstract class InstructorCoursesPageState {}

class InstructorCoursesPageInitializationState
    implements InstructorCoursesPageState {}

class InstructorCoursesPageInitializedState implements InstructorCoursesPageState {
  List<CourseEntity> courses;

  InstructorCoursesPageInitializedState({
    required this.courses,
  });
}

class InstructorCoursesPageErrorState implements InstructorCoursesPageState {}

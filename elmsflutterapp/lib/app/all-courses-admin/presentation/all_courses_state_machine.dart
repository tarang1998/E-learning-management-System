import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

import '../../../../../core/presentation/state_machine.dart';

class AllCoursesPageStateMachine
    extends StateMachine<AllCoursesPageState?, AllCoursesPageEvent> {
  AllCoursesPageStateMachine()
      : super(AllCoursesPageInitializationState());

  @override
  AllCoursesPageState? getStateOnEvent(AllCoursesPageEvent event) {
    final eventType = event.runtimeType;
    AllCoursesPageState? newState = getCurrentState();
    switch (eventType) {
      case AllCoursesPageInitializedEvent:
        AllCoursesPageInitializedEvent initializedEvent =
            event as AllCoursesPageInitializedEvent;
        newState = AllCoursesPageInitializedState(
            courses: initializedEvent.courses);
        break;

      case AllCoursesPageErrorEvent:
        newState = AllCoursesPageErrorState();
        break;

      case AllCoursesPageRefreshEvent:
        newState = AllCoursesPageInitializationState();
        break;
    }
    return newState;
  }
}

abstract class AllCoursesPageEvent {}

class AllCoursesPageLoadingEvent extends AllCoursesPageEvent {}

class AllCoursesPageRefreshEvent extends AllCoursesPageEvent{}

class AllCoursesPageInitializedEvent extends AllCoursesPageEvent {
  List<CourseEntity> courses;

  AllCoursesPageInitializedEvent({
    required this.courses,
  });
}

class AllCoursesPageErrorEvent extends AllCoursesPageEvent {}

abstract class AllCoursesPageState {}

class AllCoursesPageInitializationState
    implements AllCoursesPageState {}

class AllCoursesPageInitializedState implements AllCoursesPageState {
  List<CourseEntity> courses;

  AllCoursesPageInitializedState({
    required this.courses,
  });
}

class AllCoursesPageErrorState implements AllCoursesPageState {}

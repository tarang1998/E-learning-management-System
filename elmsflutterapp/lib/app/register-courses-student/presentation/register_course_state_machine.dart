import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

import '../../../../../core/presentation/state_machine.dart';

class RegisterCoursePageStateMachine
    extends StateMachine<RegisterCoursePageState?, RegisterCoursePageEvent> {
  RegisterCoursePageStateMachine()
      : super(RegisterCoursePageInitializationState());

  @override
  RegisterCoursePageState? getStateOnEvent(RegisterCoursePageEvent event) {
    final eventType = event.runtimeType;
    RegisterCoursePageState? newState = getCurrentState();
    switch (eventType) {
      case RegisterCoursePageInitializedEvent:
        RegisterCoursePageInitializedEvent initializedEvent =
            event as RegisterCoursePageInitializedEvent;
        newState = RegisterCoursePageInitializedState(
            courses: initializedEvent.courses);
        break;

      case RegisterCoursePageErrorEvent:
        newState = RegisterCoursePageErrorState();
        break;

      case RegisterCoursePageRefreshEvent:
        newState = RegisterCoursePageInitializationState();
        break;
    }
    return newState;
  }
}

abstract class RegisterCoursePageEvent {}

class RegisterCoursePageLoadingEvent extends RegisterCoursePageEvent {}

class RegisterCoursePageRefreshEvent extends RegisterCoursePageEvent{}

class RegisterCoursePageInitializedEvent extends RegisterCoursePageEvent {
  List<CourseEntity> courses;

  RegisterCoursePageInitializedEvent({
    required this.courses,
  });
}

class RegisterCoursePageErrorEvent extends RegisterCoursePageEvent {}

abstract class RegisterCoursePageState {}

class RegisterCoursePageInitializationState
    implements RegisterCoursePageState {}

class RegisterCoursePageInitializedState implements RegisterCoursePageState {
  List<CourseEntity> courses;

  RegisterCoursePageInitializedState({
    required this.courses,
  });
}

class RegisterCoursePageErrorState implements RegisterCoursePageState {}

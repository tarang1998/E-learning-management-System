import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

import '../../../../../core/presentation/state_machine.dart';

class CourseDescriptionMainPageStateMachine
    extends StateMachine<CourseDescriptionState, CourseDescriptionEvent> {
  CourseDescriptionMainPageStateMachine()
      : super(CourseDescriptionInitializationState());

  @override
  CourseDescriptionState getStateOnEvent(CourseDescriptionEvent event) {
    CourseDescriptionState newState = getCurrentState()!;
    switch (event.runtimeType) {
      case CourseDescriptionInitializedEvent:
        CourseDescriptionInitializedEvent initializedEvent =
            event as CourseDescriptionInitializedEvent;
        newState = CourseDescriptionInitializedState(
          course: initializedEvent.course,
        );
        break;

      case CourseDescriptionLoadingEvent:
        CourseDescriptionLoadingEvent loadingEvent =
            event as CourseDescriptionLoadingEvent;
        newState =
            CourseDescriptionLoadingState(isDeleting: loadingEvent.isDeleting);
        break;

      case CourseDescriptionErrorEvent:
        newState = CourseDescriptionErrorState();
    }
    return newState;
  }
}

abstract class CourseDescriptionState {}

class CourseDescriptionInitializationState extends CourseDescriptionState {}

class CourseDescriptionInitializedState extends CourseDescriptionState {
  final CourseEntity course;
  CourseDescriptionInitializedState({
    required this.course,
  });
}

class CourseDescriptionLoadingState extends CourseDescriptionState {
  final bool isDeleting;
  CourseDescriptionLoadingState({required this.isDeleting});
}

class CourseDescriptionErrorState extends CourseDescriptionState {}

abstract class CourseDescriptionEvent {}

class CourseDescriptionInitializedEvent extends CourseDescriptionEvent {
  final CourseEntity course;

  CourseDescriptionInitializedEvent({
    required this.course,
  });
}

class CourseDescriptionLoadingEvent extends CourseDescriptionEvent {
  final bool isDeleting;
  CourseDescriptionLoadingEvent({this.isDeleting = false});
}

class CourseDescriptionErrorEvent extends CourseDescriptionEvent {}

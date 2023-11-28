import 'package:elmsflutterapp/app/register-courses/domain/entity/courseEntity.dart';

import '../../../../../core/presentation/state_machine.dart';

class DashboardPageStateMachine
    extends StateMachine<DashboardPageState?, DashboardPageEvent> {
  DashboardPageStateMachine()
      : super(DashboardPageInitializationState());

  @override
  DashboardPageState? getStateOnEvent(DashboardPageEvent event) {
    final eventType = event.runtimeType;
    DashboardPageState? newState = getCurrentState();
    switch (eventType) {
      case DashboardPageInitializedEvent:
        DashboardPageInitializedEvent initializedEvent =
            event as DashboardPageInitializedEvent;
        newState = DashboardPageInitializedState(
            courses: initializedEvent.courses);
        break;

      case DashboardPageErrorEvent:
        newState = DashboardPageErrorState();
        break;

      case DashboardPageRefreshEvent:
        newState = DashboardPageInitializationState();
        break;
    }
    return newState;
  }
}

abstract class DashboardPageEvent {}

class DashboardPageLoadingEvent extends DashboardPageEvent {}

class DashboardPageRefreshEvent extends DashboardPageEvent{}

class DashboardPageInitializedEvent extends DashboardPageEvent {
  List<CourseEntity> courses;

  DashboardPageInitializedEvent({
    required this.courses,
  });
}

class DashboardPageErrorEvent extends DashboardPageEvent {}

abstract class DashboardPageState {}

class DashboardPageInitializationState
    implements DashboardPageState {}

class DashboardPageInitializedState implements DashboardPageState {
  List<CourseEntity> courses;

  DashboardPageInitializedState({
    required this.courses,
  });
}

class DashboardPageErrorState implements DashboardPageState {}

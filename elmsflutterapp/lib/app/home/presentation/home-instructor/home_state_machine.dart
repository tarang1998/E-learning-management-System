import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';

import '../../../../../../core/presentation/state_machine.dart';

class HomePageInstructorStateMachine
    extends StateMachine<HomePageInstructorState?, HomePageInstructorEvent> {
  HomePageInstructorStateMachine()
      : super(HomePageInstructorInitializationState());

  @override
  HomePageInstructorState? getStateOnEvent(HomePageInstructorEvent event) {
    final eventType = event.runtimeType;
    HomePageInstructorState? newState = getCurrentState();
    switch (eventType) {
      case HomePageInstructorInitializedEvent:
        HomePageInstructorInitializedEvent initEvent =
            event as HomePageInstructorInitializedEvent;
        newState = HomePageInstructorInitState(initEvent.instructorData, 0);
        break;

      case HomePageInstructorTabClickEvent:
        HomePageInstructorTabClickEvent tabClickEvent =
            event as HomePageInstructorTabClickEvent;
        newState = HomePageInstructorInitState(
            tabClickEvent.instructorData, tabClickEvent.page);
        break;

      case HomePageInstructorErrorEvent:
        HomePageInstructorErrorEvent errorEvent =
            event as HomePageInstructorErrorEvent;
        newState = HomePageInstructorErrorState(errorEvent.error.toString());
        break;
    }
    return newState;
  }
}

abstract class HomePageInstructorEvent {}

class HomePageInstructorErrorEvent extends HomePageInstructorEvent {
  final Exception error;

  HomePageInstructorErrorEvent(this.error);
}

class HomePageInstructorInitializedEvent extends HomePageInstructorEvent {
  final InstructorUserEntity instructorData;
  final int page;

  HomePageInstructorInitializedEvent(this.instructorData, this.page);
}

class HomePageInstructorTabClickEvent extends HomePageInstructorEvent {
  final InstructorUserEntity instructorData;
  final int page;

  HomePageInstructorTabClickEvent(this.instructorData, this.page);
}

abstract class HomePageInstructorState {}

class HomePageInstructorInitializationState
    implements HomePageInstructorState {}

class HomePageInstructorInitState implements HomePageInstructorState {
  InstructorUserEntity instructorData;
  final int page;

  HomePageInstructorInitState(this.instructorData, this.page);
}

class HomePageInstructorLoadingState implements HomePageInstructorState {}

class HomePageInstructorErrorState implements HomePageInstructorState {
  final String errorMessage;

  HomePageInstructorErrorState(this.errorMessage);
}

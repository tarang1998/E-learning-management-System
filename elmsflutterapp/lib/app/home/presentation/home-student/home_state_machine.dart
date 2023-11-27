import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import '../../../../../../core/presentation/state_machine.dart';

class HomePageStudentStateMachine
    extends StateMachine<HomePageStudentState?, HomePageStudentEvent> {
  HomePageStudentStateMachine() : super(HomePageStudentLoadingState());

  @override
  HomePageStudentState? getStateOnEvent(HomePageStudentEvent event) {
    final eventType = event.runtimeType;
    HomePageStudentState? newState = getCurrentState();
    switch (eventType) {
      case HomePageStudentInitializedEvent:
        HomePageStudentInitializedEvent initEvent =
            event as HomePageStudentInitializedEvent;
        newState = HomePageStudentInitState(initEvent.studentData, 0);
        break;

      case HomePageStudentTabClickEvent:
        HomePageStudentTabClickEvent tabClickEvent =
            event as HomePageStudentTabClickEvent;
        newState = HomePageStudentInitState(
            tabClickEvent.studentEntity, tabClickEvent.page);
        break;

      case HomePageStudentErrorEvent:
        HomePageStudentErrorEvent errorEvent =
            event as HomePageStudentErrorEvent;
        newState = HomePageStudentErrorState(errorEvent.error.toString());
        break;
    }
    return newState;
  }
}

abstract class HomePageStudentEvent {}

class HomePageStudentErrorEvent extends HomePageStudentEvent {
  final Exception error;

  HomePageStudentErrorEvent(this.error);
}

class HomePageStudentInitializedEvent extends HomePageStudentEvent {
  final StudentUserEntity studentData;

  HomePageStudentInitializedEvent(
    this.studentData,
  );
}

class HomePageStudentTabClickEvent extends HomePageStudentEvent {
  final StudentUserEntity studentEntity;
  final int page;

  HomePageStudentTabClickEvent(this.studentEntity, this.page);
}

abstract class HomePageStudentState {}

class HomePageStudentInitState implements HomePageStudentState {
  final StudentUserEntity studentData;
  final int page;

  HomePageStudentInitState(this.studentData, this.page);
}

class HomePageStudentLoadingState implements HomePageStudentState {}

class HomePageStudentErrorState implements HomePageStudentState {
  final String errorMessage;

  HomePageStudentErrorState(this.errorMessage);
}

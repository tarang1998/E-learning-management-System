import '../../../../core/presentation/state_machine.dart';

class HomePageStateMachine extends StateMachine<HomePageState?, HomePageEvent> {
  HomePageStateMachine() : super(new HomePageLoadingState());

  @override
  HomePageState? getStateOnEvent(HomePageEvent event) {
    final eventType = event.runtimeType;
    HomePageState? newState = getCurrentState();
    switch (eventType) {
      // case HomePageInitializedEvent:
      //   HomePageInitializedEvent initEvent = event as HomePageInitializedEvent;
      //   newState = new HomePageInitState(
      //       new ProfileEntity(initEvent.userName), 0 //page
      //       );
      //   break;

      // case HomePageTabClickEvent:
      //   HomePageTabClickEvent tabClickEvent = event as HomePageTabClickEvent;
      //   newState =
      //       new HomePageInitState(tabClickEvent.profile, tabClickEvent.page);
      //   break;

      case HomePageErrorEvent:
        HomePageErrorEvent errorEvent = event as HomePageErrorEvent;
        newState = new HomePageErrorState(errorEvent.error.toString());
        break;
    }
    return newState;
  }
}

abstract class HomePageEvent {}

class HomePageClickedEvent extends HomePageEvent {}

class HomePageErrorEvent extends HomePageEvent {
  final Exception error;

  HomePageErrorEvent(this.error);
}

class HomePageInitializedEvent extends HomePageEvent {
  final String userName;

  HomePageInitializedEvent(
    this.userName,
  );
}

// class HomePageTabClickEvent extends HomePageEvent {
//   ProfileEntity? profile;
//   final int page;

//   HomePageTabClickEvent(this.profile, this.page);
// }

abstract class HomePageState {}

// class HomePageInitState implements HomePageState {
//   ProfileEntity? profile;
//   final int page;

//   HomePageInitState(this.profile, this.page);
// }

class HomePageLoadingState implements HomePageState {}

class HomePageErrorState implements HomePageState {
  final String errorMessage;

  HomePageErrorState(this.errorMessage);
}

import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';

import '../../../../../../core/presentation/state_machine.dart';

class QuestionBankStateMachine
    extends StateMachine<QuestionBankState?, QuestionBankEvent> {
  QuestionBankStateMachine() : super(QuestionBankInitializationState());

  @override
  QuestionBankState? getStateOnEvent(QuestionBankEvent event) {
    QuestionBankState? newState;

    switch (event.runtimeType) {
      case QuestionBankInitializedEvent:
        QuestionBankInitializedEvent initializedEvent =
            event as QuestionBankInitializedEvent;
        newState = QuestionBankInitializedState(
          questions: initializedEvent.questions,
        );
        break;

      case QuestionBankInitializationEvent:
        newState= QuestionBankInitializationState();
        break;

      case QuestionBankErrorEvent:
        newState = QuestionBankErrorState();
        break;

      case QuestionBankLoadingEvent:
        newState = QuestionBankLoadingState();
        break;
    }
    return newState;
  }
}

abstract class QuestionBankState {}

class QuestionBankInitializationState extends QuestionBankState {}

class QuestionBankInitializedState extends QuestionBankState {
  final List<QuestionEntity> questions;

  QuestionBankInitializedState({required this.questions});
}

class QuestionBankLoadingState extends QuestionBankState {}

class QuestionBankErrorState extends QuestionBankState {}

abstract class QuestionBankEvent {}

class QuestionBankInitializationEvent extends QuestionBankEvent {}

class QuestionBankLoadingEvent extends QuestionBankEvent {}

class QuestionBankInitializedEvent extends QuestionBankEvent {
  final List<QuestionEntity> questions;

  QuestionBankInitializedEvent({required this.questions});
}

class QuestionBankErrorEvent extends QuestionBankEvent {}

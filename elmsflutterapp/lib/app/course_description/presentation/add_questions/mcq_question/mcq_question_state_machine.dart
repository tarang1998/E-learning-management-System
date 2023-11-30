import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../core/presentation/state_machine.dart';

class MCQQuestionStateMachine
    extends StateMachine<MCQQuestionState?, MCQQuestionEvent> {
  MCQQuestionStateMachine() : super(MCQQuestionInitializationState());

  @override
  MCQQuestionState? getStateOnEvent(MCQQuestionEvent event) {
    MCQQuestionState? newState;
    switch (event.runtimeType) {
      case MCQQuestionInitializedEvent:
        MCQQuestionInitializedEvent initializedEvent =
            event as MCQQuestionInitializedEvent;
        newState = MCQQuestionInitializedState(
            courseId: initializedEvent.courseId,
            questionImages: initializedEvent.questionImages,
            optionImages: initializedEvent.optionImages,
            options: initializedEvent.options,
            solutionImages: initializedEvent.questionSolutionImages);
        break;

      case MCQAddQuestionNewQuestionImageEvent:
        MCQAddQuestionNewQuestionImageEvent addImageEvent =
            event as MCQAddQuestionNewQuestionImageEvent;
        MCQQuestionInitializedState prevState =
            getCurrentState() as MCQQuestionInitializedState;
        newState = MCQQuestionInitializedState.clone(
          prevState,
          questionImages: [
            ...prevState.questionImages,
            ...addImageEvent.newQuestionImages,
          ],
        );
        break;

      case MCQAddQuestionDeleteQuestionImageEvent:
        MCQAddQuestionDeleteQuestionImageEvent deleteImageEvent =
            event as MCQAddQuestionDeleteQuestionImageEvent;
        MCQQuestionInitializedState prevState =
            getCurrentState() as MCQQuestionInitializedState;
        newState = MCQQuestionInitializedState.clone(
          prevState,
          questionImages: [...deleteImageEvent.remainingQuestionImages],
        );
        break;

      case MCQQuestionAddOptionUpdatedEvent:
        MCQQuestionAddOptionUpdatedEvent optionUpdatedEvent =
            event as MCQQuestionAddOptionUpdatedEvent;
        List<MCQOptionEntity> options =
            (getCurrentState() as MCQQuestionInitializedState).options;
        options[optionUpdatedEvent.index] = optionUpdatedEvent.optionEntity;
        newState = MCQQuestionInitializedState.clone(
            getCurrentState() as MCQQuestionInitializedState,
            options: options);
        break;

      case MCQAddQuestionDeleteOptionImageEvent:
        MCQAddQuestionDeleteOptionImageEvent deleteOptionImageEvent =
            event as MCQAddQuestionDeleteOptionImageEvent;
        MCQQuestionInitializedState prevState =
            getCurrentState() as MCQQuestionInitializedState;
        Map<int, List<PlatformFile>> optionImages = prevState.optionImages;
        optionImages[deleteOptionImageEvent.index] =
            deleteOptionImageEvent.remainingImages;
        newState = MCQQuestionInitializedState.clone(prevState,
            optionImages: optionImages);
        break;

      case MCQAddQuestionAddOptionImageEvent:
        MCQAddQuestionAddOptionImageEvent addOptionImageEvent =
            event as MCQAddQuestionAddOptionImageEvent;
        MCQQuestionInitializedState prevState =
            getCurrentState() as MCQQuestionInitializedState;
        Map<int, List<PlatformFile>> optionImages = prevState.optionImages;
        optionImages[addOptionImageEvent.index]!
            .addAll(addOptionImageEvent.newImages);
        newState = MCQQuestionInitializedState.clone(prevState,
            optionImages: optionImages);
        break;

      case MCQAddQuestionSolutionNewImageEvent:
        MCQAddQuestionSolutionNewImageEvent addImageEvent =
            event as MCQAddQuestionSolutionNewImageEvent;
        MCQQuestionInitializedState prevState =
            getCurrentState() as MCQQuestionInitializedState;
        newState = MCQQuestionInitializedState.clone(
          prevState,
          solutionImages: [
            ...prevState.solutionImages,
            ...addImageEvent.newSolutionQuestionImages,
          ],
        );
        break;

      case MCQAddQuestionDeleteSolutionImageEvent:
        MCQAddQuestionDeleteSolutionImageEvent deleteImageEvent =
            event as MCQAddQuestionDeleteSolutionImageEvent;
        MCQQuestionInitializedState prevState =
            getCurrentState() as MCQQuestionInitializedState;
        newState = MCQQuestionInitializedState.clone(
          prevState,
          solutionImages: [...deleteImageEvent.remainingQuestionSolutionImages],
        );
        break;

      case MCQQuestionLoadingEvent:
        newState = MCQQuestionLoadingState();
        break;

      case MCQQuestionErrorEvent:
        newState = MCQQuestionErrorState();
        break;
    }
    return newState;
  }
}

abstract class MCQQuestionState {}

class MCQQuestionInitializationState extends MCQQuestionState {}

class MCQQuestionInitializedState extends MCQQuestionState {
  final String courseId;
  final String? validationMessage;
  final List<PlatformFile> questionImages;
  final Map<int, List<PlatformFile>> optionImages;
  final List<MCQOptionEntity> options;
  final List<PlatformFile> solutionImages;

  MCQQuestionInitializedState(
      {required this.courseId,
      required this.questionImages,
      required this.optionImages,
      required this.options,
      this.validationMessage,
      required this.solutionImages});

  MCQQuestionInitializedState.clone(
    MCQQuestionInitializedState prevState, {
    String? courseId,
    String? validationMessage,
    List<PlatformFile>? questionImages,
    List<PlatformFile>? solutionImages,
    Map<int, List<PlatformFile>>? optionImages,
    List<MCQOptionEntity>? options,
  }) : this(
            courseId: courseId ?? prevState.courseId,
            questionImages: questionImages ?? prevState.questionImages,
            validationMessage: validationMessage ?? prevState.validationMessage,
            optionImages: optionImages ?? prevState.optionImages,
            options: options ?? prevState.options,
            solutionImages: solutionImages ?? prevState.solutionImages);
}

class MCQQuestionLoadingState extends MCQQuestionState {}

class MCQQuestionErrorState extends MCQQuestionState {}

abstract class MCQQuestionEvent {}

class MCQQuestionInitializedEvent extends MCQQuestionEvent {
  final String courseId;
  final List<PlatformFile> questionImages;
  final Map<int, List<PlatformFile>> optionImages;
  final List<MCQOptionEntity> options;
  final List<PlatformFile> questionSolutionImages;

  MCQQuestionInitializedEvent(
      {required this.courseId,
      required this.questionImages,
      required this.optionImages,
      required this.options,
      required this.questionSolutionImages});
}

class MCQAddQuestionNewQuestionImageEvent extends MCQQuestionEvent {
  final List<PlatformFile> newQuestionImages;
  MCQAddQuestionNewQuestionImageEvent(this.newQuestionImages);
}

class MCQAddQuestionDeleteQuestionImageEvent extends MCQQuestionEvent {
  final List<PlatformFile> remainingQuestionImages;
  MCQAddQuestionDeleteQuestionImageEvent(this.remainingQuestionImages);
}

class MCQQuestionAddOptionUpdatedEvent extends MCQQuestionEvent {
  final MCQOptionEntity optionEntity;
  final int index;

  MCQQuestionAddOptionUpdatedEvent(
      {required this.optionEntity, required this.index});
}

class MCQAddQuestionDeleteOptionImageEvent extends MCQQuestionEvent {
  final List<PlatformFile> remainingImages;
  final int index;
  MCQAddQuestionDeleteOptionImageEvent(
      {required this.index, required this.remainingImages});
}

class MCQAddQuestionAddOptionImageEvent extends MCQQuestionEvent {
  final List<PlatformFile> newImages;
  final int index;
  MCQAddQuestionAddOptionImageEvent(
      {required this.index, required this.newImages});
}

class MCQAddQuestionSolutionNewImageEvent extends MCQQuestionEvent {
  final List<PlatformFile> newSolutionQuestionImages;
  MCQAddQuestionSolutionNewImageEvent(this.newSolutionQuestionImages);
}

class MCQAddQuestionDeleteSolutionImageEvent extends MCQQuestionEvent {
  final List<PlatformFile> remainingQuestionSolutionImages;
  MCQAddQuestionDeleteSolutionImageEvent(this.remainingQuestionSolutionImages);
}

class MCQQuestionLoadingEvent extends MCQQuestionEvent {}

class MCQQuestionErrorEvent extends MCQQuestionEvent {}

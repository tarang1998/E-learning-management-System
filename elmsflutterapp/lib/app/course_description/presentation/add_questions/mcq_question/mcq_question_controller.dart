import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/mcq_question_presenter.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'mcq_question_state_machine.dart';

class MCQQuestionController extends Controller {
  final MCQQuestionPresenter _presenter;
  final MCQQuestionStateMachine _stateMachine = MCQQuestionStateMachine();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();

  MCQQuestionController() : _presenter = serviceLocator<MCQQuestionPresenter>();

  TextEditingController solutionSectionText = TextEditingController();

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  MCQQuestionState getCurrentState() => _stateMachine.getCurrentState()!;

  void handleBackPress() => _navigationService.navigateBack();

  void initialize(courseId) {
    Map<int, List<PlatformFile>> optionImages = {};

    List<MCQOptionEntity> options = [];
    for (int i = 0; i < 5; i++) {
      optionImages[i] = [];
      options.add(MCQOptionEntity(optionText: null, isCorrect: false));
    }

    _stateMachine.onEvent(MCQQuestionInitializedEvent(
        courseId: courseId,
        questionImages: [],
        optionImages: optionImages,
        options: options,
        questionSolutionImages: []));
    refreshUI();
  }

  void addImagesToNewQuestion(List<PlatformFile> newImages) {
    _stateMachine.onEvent(MCQAddQuestionNewQuestionImageEvent(newImages));
    refreshUI();
  }

  void deleteImagesFromNewQuestion(List<PlatformFile> remainingImages) {
    _stateMachine
        .onEvent(MCQAddQuestionDeleteQuestionImageEvent(remainingImages));
    refreshUI();
  }

  void mcqOptionUpdated({
    required String optionText,
    required int index,
    required bool isSelected,
  }) {
    _stateMachine.onEvent(MCQQuestionAddOptionUpdatedEvent(
        optionEntity: MCQOptionEntity(
          isCorrect: isSelected,
          optionText: optionText.trim(),
        ),
        index: index));

    refreshUI();
  }

  void deleteOptionImagesFromNewQuestion(
      List<PlatformFile> remainingImages, int index) {
    _stateMachine.onEvent(MCQAddQuestionDeleteOptionImageEvent(
        index: index, remainingImages: remainingImages));
    refreshUI();
  }

  void addOptionImagesToNewQuestion(List<PlatformFile> newImages, int index) {
    _stateMachine.onEvent(
        MCQAddQuestionAddOptionImageEvent(index: index, newImages: newImages));
    refreshUI();
  }

  void addSolutionImagesToNewQuestion(List<PlatformFile> newSolutionImages) {
    _stateMachine
        .onEvent(MCQAddQuestionSolutionNewImageEvent(newSolutionImages));
    refreshUI();
  }

  void deleteSolutionImagesFromNewQuestion(List<PlatformFile> remainingImages) {
    _stateMachine
        .onEvent(MCQAddQuestionDeleteSolutionImageEvent(remainingImages));
    refreshUI();
  }

  bool validate({
    required String questionText,
    required MCQQuestionInitializedState? addInitializedState,
  }) {
    if (questionText.isEmpty && addInitializedState!.questionImages.isEmpty)
      return false;

    if (solutionSectionText.text.isEmpty && addInitializedState!.solutionImages.isEmpty)
      return false;


    int optionCounter = 0;
    int tickCounter = 0;

    for (int i = 0; i < addInitializedState!.options.length; i++) {
      if (addInitializedState.options[i].isCorrect == true) tickCounter++;
      if (addInitializedState.options[i].optionText != null) {
        if (addInitializedState.options[i].optionText!.trim().isNotEmpty)
          optionCounter++;
        else {
          int numberOfOptionImages =
              (addInitializedState.optionImages[i]!.length);
          if (numberOfOptionImages > 0) optionCounter++;
        }
      } else {
        int numberOfOptionImages = 0;
        numberOfOptionImages = numberOfOptionImages +
            (addInitializedState.optionImages[i]!.length);
        if (numberOfOptionImages > 0) optionCounter++;
      }
    }

    if (tickCounter == 0) return false;
    if (optionCounter < 2) return false;

    return true;
  }

  void handleAddQuestion({
    required List<MCQOptionEntity> options,
    required String questionText,
    required String courseId,
    required List<PlatformFile> questionImages,
    required Map<int, List<PlatformFile>?>? optionMedia,
    required String questionSolutionText,
    List<PlatformFile>? questionSolutionImages,
  }) {
    _stateMachine.onEvent(MCQQuestionLoadingEvent());
    refreshUI();


    // _presenter.addQuestion(
    //     UseCaseObserver(
    //       () {
    //         _presenter
    //             .notifySubmissionOfQuestion(UseCaseObserver(() {}, (error) {}));
    //         UtilitiesWrapper.toast(msg: 'Question Added Successfully');
    //         _navigationService.navigateBack();
    //         if (isWeb) _navigationService.navigateBack();
    //       },
    //       (error) {
    //         _stateMachine.onEvent(MCQQuestionErrorEvent());
    //         refreshUI();
    //       },
    //     ),
    //     question: question,
    //     questionMedia: questionImages,
    //     optionMedia: optionMedia,
    //     bloomsName: bloom?.bloomName,
    //     questionSolutionImages: questionSolutionImages,
    //     questionSolutionText: solutionSectionText.text);
  }
}

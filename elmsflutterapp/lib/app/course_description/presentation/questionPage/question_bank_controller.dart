import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'question_bank_presenter.dart';
import 'question_bank_state_machine.dart';

class QuestionBankController extends Controller {
  final QuestionBankPresenter _presenter;
  final QuestionBankStateMachine _stateMachine = QuestionBankStateMachine();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();

  QuestionBankController()
      : _presenter = serviceLocator<QuestionBankPresenter>(),
        super();

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  QuestionBankState? getCurrentState() => _stateMachine.getCurrentState();

  void handleBackPress() => _navigationService.navigateBack();

  void initialize({
    required String courseId,
  }) async {
    _presenter.getQuestionForCourse(
        UseCaseObserver(() {}, (error) {
          _stateMachine
              .onEvent(QuestionBankErrorEvent());
          refreshUI();
        }, onNextFunc: (List<QuestionEntity> questions) {
          _stateMachine.onEvent(new QuestionBankInitializedEvent(questions: questions) );
          refreshUI();

        }),
        courseId: courseId);
  }

  Future<void> handleRefresh() async {
    _stateMachine.onEvent(QuestionBankInitializationEvent());
    refreshUI();
  
  }
}

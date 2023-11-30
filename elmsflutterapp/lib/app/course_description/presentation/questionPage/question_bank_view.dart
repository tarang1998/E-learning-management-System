import 'package:elmsflutterapp/app/course_description/presentation/questionPage/question_bank_controller.dart';
import 'package:elmsflutterapp/app/course_description/presentation/questionPage/question_bank_state_machine.dart';
import 'package:elmsflutterapp/app/course_description/presentation/questionPage/widgets/expanded_question_card.dart';
import 'package:elmsflutterapp/app/course_description/presentation/questionPage/widgets/select_question_type_dialog.dart';
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;

class QuestionBankPage extends fa.View {
  final QuestionBankPageParams params;

  QuestionBankPage({required this.params});
  @override
  State<StatefulWidget> createState() => QuestionBankPageState();
}

class QuestionBankPageState
    extends fa.ResponsiveViewState<QuestionBankPage, QuestionBankController> {
  QuestionBankPageState() : super(QuestionBankController());

  @override
  Widget get desktopView => fa.ControlledWidgetBuilder<QuestionBankController>(
          builder: (context, controller) {
        final state = controller.getCurrentState();
        final currentState = controller.getCurrentState().runtimeType;
        print("buildDesktopView called with state $currentState");
        switch (currentState) {
          case QuestionBankInitializationState:
            return buildInitializationStateViewWeb(
              controller,
            );

          case QuestionBankInitializedState:
            QuestionBankInitializedState initializedState =
                state as QuestionBankInitializedState;
            return buildInitializedViewWeb(
              context: context,
              controller: controller,
              initializedState: initializedState,
              shouldAddEditQuestions: true,
            );

          case QuestionBankLoadingState:
            return buildLoadingStateViewWeb();

          case QuestionBankErrorState:
            return _buildErrorStateView(
                "Some error has occured. Please try again later ");
        }
        throw Exception("Unrecognized state $currentState encountered");
      });

  @override
  Widget get mobileView => desktopView;
  @override
  Widget get tabletView => desktopView;
  @override
  Widget get watchView => throw UnimplementedError();

  Widget buildInitializationStateViewWeb(QuestionBankController controller) {
    controller.initialize(courseId: widget.params.courseId);
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildLoadingStateViewWeb() {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorStateView(String error) {
    return Scaffold(
        key: globalKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ));
  }

  Widget buildInitializedViewWeb({
    required BuildContext context,
    required QuestionBankController controller,
    required QuestionBankInitializedState initializedState,
    required bool shouldAddEditQuestions,
  }) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () async => await controller.handleRefresh(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.topCenter,
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Questions",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    )),
                if (shouldAddEditQuestions)
                  Row(
                    children: [
                      buildAddQuestionCard(
                        context: context,
                        controller: controller,
                        initializedState: initializedState,
                      ),
                    ],
                  ),
                if (initializedState.questions.isEmpty &&
                    !shouldAddEditQuestions)
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text(
                      "No Questions Present in this course",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ...initializedState.questions.map(
                  (question) {
                    return ExpandedQuestionCard(
                      controller: controller,
                      question: question,
                      courseId: widget.params.courseId,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddQuestionCard({
    required BuildContext context,
    required QuestionBankController controller,
    required QuestionBankInitializedState initializedState,
  }) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _showSelectQuestionTypeDialog(
            context,
            controller,
            initializedState,
          ),
          child: Container(
            margin: EdgeInsets.all(getScreenWidth(context) * 0.01),
            child: Material(
              elevation: 6,
              color: Theme.of(context).cardColor,
              shape: Theme.of(context).cardTheme.shape,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
                child: ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 6),
                    Text("Add Question"),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSelectQuestionTypeDialog(
    BuildContext context,
    QuestionBankController controller,
    QuestionBankInitializedState initializedState,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectQuestionTypeDialog(
        controller: controller,
        courseId: widget.params.courseId,
      ),
    );
  }
}

class QuestionBankPageParams {
  final String courseId;
  final bool shouldAddEditQuestions;
  QuestionBankPageParams({
    required this.courseId,
    required this.shouldAddEditQuestions,
  });
}

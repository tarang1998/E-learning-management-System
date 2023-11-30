import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/mcq_content_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;

import 'mcq_question_controller.dart';
import 'mcq_question_state_machine.dart';

class MCQQuestionPage extends fa.View {
  final MCQQuestionPageParams params;
  MCQQuestionPage({required this.params}) : super(key: null);

  @override
  State<StatefulWidget> createState() => MCQQuestionPageView();
}

class MCQQuestionPageView
    extends fa.ResponsiveViewState<MCQQuestionPage, MCQQuestionController> {
  MCQQuestionPageView() : super(MCQQuestionController());

  @override
  Widget get desktopView => fa.ControlledWidgetBuilder<MCQQuestionController>(
          builder: (context, controller) {
        final state = controller.getCurrentState();
        final currentState = controller.getCurrentState().runtimeType;
        switch (currentState) {
          case MCQQuestionInitializationState:
            return buildInitializationStateViewWeb(
              controller,
            );

          case MCQQuestionInitializedState:
            return buildInitializedViewWeb(
              context: context,
              controller: controller,
              initializedState: state as MCQQuestionInitializedState,
            );

        

          case MCQQuestionLoadingState:
            return buildLoadingStateViewWeb();

          case MCQQuestionErrorState:
            return _buildErrorStateView("Some error occured. Please try again later");
        }
        throw Exception("Unrecognized state $currentState encountered");
      });

  @override
  Widget get mobileView => desktopView;

  @override
  Widget get tabletView => mobileView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget buildInitializationStateViewWeb(MCQQuestionController controller) {
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => controller.initialize(widget.params.courseId));
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildInitializedViewWeb({
    required BuildContext context,
    required MCQQuestionController controller,
    required MCQQuestionInitializedState initializedState,
  }) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                    size: 25,
                  ),
                  onPressed: controller.handleBackPress,
                ),
                Text("Add MCQ Question",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: 'Ubuntu'))
              ],
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(child: 
                    MCQQuestionContentBody(
                      controller: controller,
                      initializedState: initializedState,
                    ),
                    ),
              ),
            )
          ],
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
}

class MCQQuestionPageParams {
  final String courseId;

  MCQQuestionPageParams({
    required this.courseId,
  });
}

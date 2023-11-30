import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/mcq_question_controller.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/mcq_question_state_machine.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/expanded_solution_section_widget.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/max_marks_widget.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/mcq_option_widgets_list.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/question_widget.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/submit_button_widget.dart';
import 'package:flutter/material.dart';

class MCQQuestionContentBody extends StatefulWidget {
  final MCQQuestionController controller;
  final MCQQuestionInitializedState initializedState;

  const MCQQuestionContentBody({
    required this.controller,
    required this.initializedState,
  }) : super();

  @override
  _ContentBodyState createState() => _ContentBodyState();
}

class _ContentBodyState extends State<MCQQuestionContentBody> {
  late final TextEditingController questionTextController;
  late final TextEditingController maxMarksTextController;

  @override
  void initState() {
    super.initState();
    questionTextController = TextEditingController();
    maxMarksTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          QuestionWidget(
            questionType: "MCQ",
            questionTextController: questionTextController,
            newQuestionImages: widget.initializedState.questionImages,
            addImagesToNewQuestion: widget.controller.addImagesToNewQuestion,
            deleteImagesFromNewQuestion:
                widget.controller.deleteImagesFromNewQuestion,
          ),
          MaxMarksWidget(
            controller: widget.controller,
            maxMarksTextController: maxMarksTextController,
          ),
          MCQOptionsWidgetsList(
            controller: widget.controller,
            addInitializedState: widget.initializedState,
          ),
          ExpandedSolutionSection(
            newQuestionSolutionImages: widget.initializedState.solutionImages,
            controller: widget.controller,
          ),
          if (widget.initializedState.validationMessage != null)
            Text(widget.initializedState.validationMessage!,
                style: TextStyle(color: Colors.red[400], fontFamily: 'Ubuntu')),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SubmitButtonWidget(
              maxMarks: maxMarksTextController.text.isEmpty
                  ? 0
                  : num.parse(maxMarksTextController.text),
              controller: widget.controller,
              questionText: questionTextController.text,
              addInitializedState: widget.initializedState,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

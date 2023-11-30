import 'package:flutter/material.dart';
import '../mcq_question_controller.dart';
import '../mcq_question_state_machine.dart';

class SubmitButtonWidget extends StatefulWidget {
  final MCQQuestionController controller;
  final String questionText;
  final num maxMarks;
  final MCQQuestionInitializedState? addInitializedState;

  const SubmitButtonWidget({
    required this.questionText,
    required this.maxMarks,
    required this.controller,
    this.addInitializedState,
  });

  @override
  _SubmitButtonWidgetState createState() => _SubmitButtonWidgetState();
}

class _SubmitButtonWidgetState extends State<SubmitButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 40,
        margin: const EdgeInsets.only(top: 10),
        child: GestureDetector(
          child: Container(
            decoration: widget.controller.validate(
                    questionText: widget.questionText,
                    addInitializedState: widget.addInitializedState)
                ? BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 40.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                    ],
                  )
                : BoxDecoration(
                    color: const Color(0xFFD1D3D5),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 40.0,
                        spreadRadius: 0.0,
                        offset: const Offset(
                          0.0,
                          0.0,
                        ),
                      ),
                    ],
                  ),
            child: Center(
              child: Text(
                "Submit Question",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontFamily: 'Ubuntu'),
              ),
            ),
          ),
          onTap: () {
            FocusScope.of(context).unfocus();
            if (widget.controller.validate(
                questionText: widget.questionText,
                addInitializedState: widget.addInitializedState)) {
              widget.controller.handleAddQuestion(
                courseId: widget.addInitializedState!.courseId,
                optionMedia: widget.addInitializedState!.optionImages,
                questionImages: widget.addInitializedState!.questionImages,
                questionText: widget.questionText,
                  options: widget.addInitializedState!.options,
                  questionSolutionText:
                      widget.controller.solutionSectionText.text,
                  questionSolutionImages:
                      widget.addInitializedState!.solutionImages);
            }
          },
        ),
      ),
    );
  }
}

import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

import '../question_bank_controller.dart';
import 'mcq_question_card.dart';
import 'subjective_question_card.dart';

class ExpandedQuestionCard extends StatefulWidget {
  final QuestionEntity question;
  final String courseId;
  final QuestionBankController controller;

  const ExpandedQuestionCard({
    required this.courseId,
    required this.question,
    required this.controller,
  });

  @override
  _ExpandedQuestionCardState createState() => _ExpandedQuestionCardState();
}

class _ExpandedQuestionCardState extends State<ExpandedQuestionCard> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getScreenWidth(context) * 0.01),
      child: Material(
        elevation: 6,
        color: Theme.of(context).cardColor,
        shape: Theme.of(context).cardTheme.shape,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: ExpansionTile(
            onExpansionChanged: (newValue) => setState(() => isOpen = newValue),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: isOpen
                      ? Text(
                          widget.question.questionText,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 15,
                              fontFamily: "UbuntuRegular",
                              fontWeight: FontWeight.w400),
                        )
                      : Text(
                          widget.question.questionText,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 15,
                              fontFamily: "UbuntuRegular",
                              fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Icon(Icons.list, color: Color(0xFFB9BDBF)),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        widget.question is MCQQuestionEntity
                            ? "MCQ"
                            : "Subjective",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontFamily: "Ubuntu"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: _buildContentBody(
              context: context,
              controller: widget.controller,
              courseId: widget.courseId,
              question: widget.question,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContentBody({
    required BuildContext context,
    required QuestionBankController controller,
    required QuestionEntity question,
    required String courseId,
  }) {
    Widget? _contentBody;
    switch (question.runtimeType) {
      case MCQQuestionEntity:
        _contentBody = MCQQuestionCard(
          controller: controller,
          courseId: courseId,
          question: question as MCQQuestionEntity,
        );
        break;

      case SubjectiveQuestionEntity:
        _contentBody = SubjectiveQuestionCard(
          controller: controller,
          courseId: courseId,
          question: question as SubjectiveQuestionEntity,
        );
        break;
    }
    return [_contentBody!];
  }
}

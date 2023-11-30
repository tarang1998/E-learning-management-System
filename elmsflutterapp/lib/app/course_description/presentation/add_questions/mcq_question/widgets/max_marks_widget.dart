import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/mcq_question_controller.dart';
import 'package:flutter/material.dart';


class MaxMarksWidget extends StatefulWidget {
  final TextEditingController maxMarksTextController;
  final MCQQuestionController controller;

  const MaxMarksWidget({
    required this.maxMarksTextController,
    required this.controller,
  });

  @override
  _MaxMarksWidgetState createState() => _MaxMarksWidgetState();
}

class _MaxMarksWidgetState extends State<MaxMarksWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 400,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(width: 1, color: const Color(0xFFE7E9E9))),
        child: TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(
            color: Color.fromARGB(255, 38, 40, 42),
            fontFamily: "UbuntuRegular",
          ),
          controller: widget.maxMarksTextController,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Question marks",
            hintStyle: const TextStyle(
              fontSize: 15.0,
              color: Color(0xFFB9BDBF),
              fontFamily: "UbuntuRegular",
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/mcq_question_view.dart';
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

import '../question_bank_controller.dart';

class SelectQuestionTypeDialog extends StatelessWidget {
  final QuestionBankController controller;
  final String courseId;
  const SelectQuestionTypeDialog({
    Key? key,
    required this.controller,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    final screenHeight = getScreenHeight(context);
    final buttonStyle = ElevatedButton.styleFrom(
        fixedSize: const Size(250, 0),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: Colors.white,
            fontFamily: 'Ubuntu'));
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1, vertical: screenHeight * 0.3),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  ),
                  onPressed: controller.handleBackPress,
                ),
                Text(
                  "Select Question Type",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                      fontFamily: 'Ubuntu'),
                )
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => showQuestionSubmissionDialogPopup(
                  type: "MCQ", context: context, courseId: courseId),
              style: buttonStyle,
              child: Text(
                "MCQ",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => showQuestionSubmissionDialogPopup(
                type: "SUBJECTIVE",
                context: context,
                courseId: courseId
              ),
              style: buttonStyle,
              child: Text(
                "SUBJECTIVE",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

showQuestionSubmissionDialogPopup({
  required String type,
  required BuildContext context,
  required String courseId,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
              // horizontal: MediaQuery.of(context).size.width / 3.8,
              vertical: MediaQuery.of(context).size.height / 10),
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 30.0,
                ),
              ]),
          child: type == "MCQ"
              ? MCQQuestionPage(
                  params: MCQQuestionPageParams(
                  courseId: courseId,
                ))
              : type == "SUBJECTIVE"
                  ? Text("Coming Soon")
                  : throw Exception(),
        );
      });
}

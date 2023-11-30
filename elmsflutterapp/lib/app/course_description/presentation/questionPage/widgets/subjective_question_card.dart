import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/core/presentation/widgets/show_image_overlay.dart';
import 'package:flutter/material.dart';
import '../question_bank_controller.dart';

class SubjectiveQuestionCard extends StatelessWidget {
  final QuestionBankController controller;
  final SubjectiveQuestionEntity question;
  final String courseId;

  const SubjectiveQuestionCard({
    Key? key,
    required this.controller,
    required this.question,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        
        if (question.media != null)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: question.media!.mediaObjects.map(
                (media) {
                  return media is ImageMediaObject
                      ? Container(
                          width: 150,
                          margin: const EdgeInsets.only(left: 15),
                          child: ShowImageOverlay(
                            imagepath: media.imageUri,
                          ),
                        )
                      : Container();
                },
              ).toList(),
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'Max Marks :   ${question.marks}',
            style:  TextStyle(color: Colors.black87, fontSize: 18, fontFamily: "Ubuntu"),
            textAlign: TextAlign.center,
          ),
        ),
        if (question.questionSolutionText != null ||
            question.questionSolutionImages != null)
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: Colors.grey,
                  height: 30,
                  thickness: 1,
                ),
                Text(
                    "Solution" +
                        ':',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontFamily: "Ubuntu")
                        .copyWith(fontSize: 15, color: Colors.blue)),
                const SizedBox(height: 10.0),
                if (question.questionSolutionText != null &&
                    question.questionSolutionText!.isNotEmpty)
                  Text(question.questionSolutionText!),
                const SizedBox(height: 10),
                if (question.questionSolutionImages != null)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          question.questionSolutionImages!.mediaObjects.map(
                        (media) {
                          return media is ImageMediaObject
                              ? Container(
                                  width: 150,
                                  margin: const EdgeInsets.only(left: 5.0),
                                  child: ShowImageOverlay(
                                    imagepath: media.imageUri,
                                  ),
                                )
                              : Container();
                        },
                      ).toList(),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  
}

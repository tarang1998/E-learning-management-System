import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/core/presentation/widgets/show_image_overlay.dart';
import 'package:flutter/material.dart';

import '../question_bank_controller.dart';

class MCQQuestionCard extends StatelessWidget {
  final QuestionBankController controller;
  final MCQQuestionEntity question;
  final String courseId;

  const MCQQuestionCard({
    Key? key,
    required this.controller,
    required this.question,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MCQOptionEntity> options = question.mcqOptions;

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
        for (MCQOptionEntity option in options)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Expanded(child: Text(option.optionText!)),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: option.isCorrect! ? 0 : 1,
                          color: Colors.blue,
                        ),
                        color: option.isCorrect!
                            ? Colors.blue
                            : Colors.transparent,
                      ),
                      child: Icon(
                        Icons.check,
                        color: option.isCorrect!
                            ? Colors.white
                            : Colors.transparent,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                if (option.media != null)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: option.media!.mediaObjects.map(
                        (media) {
                          return media.runtimeType == ImageMediaObject
                              ? Container(
                                  width: 150,
                                  margin: const EdgeInsets.only(left: 15),
                                  child: ShowImageOverlay(
                                    imagepath:
                                        (media as ImageMediaObject).imageUri,
                                    heightOfImage: 150,
                                    printLog: "Option Image clicked",
                                  ),
                                )
                              : Container();
                        },
                      ).toList(),
                    ),
                  )
              ],
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
                  color: Colors.black,
                  height: 30,
                  thickness: 1,
                ),
                Text("Solution" + ':',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        fontFamily: "Ubuntu")),
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
        const SizedBox(height: 10)
      ],
    );
  }

  
}

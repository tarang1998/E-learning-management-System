import 'package:elmsflutterapp/app/course_description/presentation/questionPage/question_bank_view.dart';
import 'package:flutter/material.dart';

class CourseQuestionScreen extends StatefulWidget {
  const CourseQuestionScreen({
    Key? key,
    required this.params,
  }) : super(key: key);

  final CourseQuestionScreenParams params;

  @override
  _CourseQuestionScreenState createState() => _CourseQuestionScreenState();
}

class _CourseQuestionScreenState extends State<CourseQuestionScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Widget _pageTitle = Hero(
        tag: "Questions",
        child: Material(
          color: Colors.transparent,
          child: Text(
            "Questions",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ));
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                      onPressed: Navigator.of(context).pop,
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      )),
                  _pageTitle,
                ],
              )),
          QuestionBankPage(
              params: QuestionBankPageParams(
            courseId: widget.params.courseId,
            shouldAddEditQuestions: true,
          )),
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CourseQuestionScreenParams {
  final String courseId;
  CourseQuestionScreenParams({
    required this.courseId,
  });
}

import 'package:elmsflutterapp/app/course_description/presentation/course_description_controller.dart';
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class DeleteCourseDialog extends StatelessWidget {
  final String courseName;
  final String courseId;
  final CourseDescriptionMainPageController controller;
  const DeleteCourseDialog({
    Key? key,
    required this.controller,
    required this.courseId,
    required this.courseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Card(
          child: Container(
            width: getScreenWidth(context) * .3,
            decoration: const BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                      fontFamily: "Ubuntu"),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "Are you sure you to delete this subject ",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' "$courseName" ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w200,
                                color: Colors.blue,
                                fontFamily: 'Ubuntu')),
                        onPressed: controller.handleBackPressed,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              fontFamily: 'Ubuntu'),
                        ),
                        onPressed: () => {
                        }
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

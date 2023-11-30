import 'package:elmsflutterapp/app/course_description/presentation/course_description_controller.dart';
import 'package:elmsflutterapp/app/course_description/presentation/course_description_state_machine.dart';
import 'package:elmsflutterapp/app/course_description/presentation/questionPage/question_bank_view.dart';
import 'package:elmsflutterapp/app/course_description/presentation/widget/delete_course_dialog.dart';
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CourseDescriptionScreenWeb extends StatefulWidget {
  const CourseDescriptionScreenWeb({
    Key? key,
    required this.controller,
    required this.initializedState,
  }) : super(key: key);

  final CourseDescriptionMainPageController controller;
  final CourseDescriptionInitializedState initializedState;

  @override
  _CourseDescriptionScreenWebState createState() =>
      _CourseDescriptionScreenWebState();
}

class _CourseDescriptionScreenWebState extends State<CourseDescriptionScreenWeb>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Container(
            width: getScreenWidth(context) * 0.35,
            child: buildCourseDescription(
              currentPage: _currentPage,
              pageController: _pageController,
              controller: widget.controller,
              initializedState: widget.initializedState,
            ),
          ),
          Expanded(
            child: Card(
              elevation: 2,
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Course Description",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: "Ubuntu"
                              //fontFamily: "ubuntu"
                              ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          widget.initializedState.course.description,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontFamily: "Ubuntu"
                              //fontFamily: "ubuntu"
                              ),
                        )
                      ],
                    ),
                  ),
                  QuestionBankPage(
                      params: QuestionBankPageParams(
                          shouldAddEditQuestions: true,
                          courseId: widget.initializedState.course.id)),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Quiz",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Coming Soon",
                              style: TextStyle(
                                color: Colors.red,
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  Text("Resources"),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget buildCourseDescription({
    required int currentPage,
    required PageController pageController,
    required CourseDescriptionMainPageController controller,
    required CourseDescriptionInitializedState initializedState,
  }) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: widget.controller.handleBackPressed,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.blue,
              ),
            ),
            Flexible(
              child: Text(
                widget.initializedState.course.name,
                style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: "Ubuntu"),
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          height: 30,
          thickness: 2,
        ),
        _buildOptionCard(
            pageNo: 0,
            isSelected: currentPage == 0,
            icon: Icons.category_outlined,
            text: "Course Description"),
        _buildOptionCard(
            pageNo: 1,
            isSelected: currentPage == 1,
            icon: Icons.menu_book_outlined,
            text: "Questions"),
        _buildOptionCard(
            pageNo: 2,
            isSelected: currentPage == 2,
            icon: Icons.insert_link,
            text: "Quiz"),
        _buildOptionCard(
            pageNo: 3,
            isSelected: currentPage == 3,
            icon: Icons.insert_link,
            text: "Resources"),
        _buildEditSubjectCard(
          onTap: () =>
              showDialog(context: context, builder: (_) => Text("edit subject")

                  // EditSubjectDialog(
                  //   isWeb: true,
                  //   subjectName: initializedState.subjectName,
                  //   onUpdate: (newSubjectName) {
                  //     controller.handleBackPressed();
                  //     controller.handleEditSubject(
                  //       subjectId: initializedState.subjectId,
                  //       subjectName: newSubjectName,
                  //       subjectCode: null,
                  //     );
                  //   },
                  // ),
                  ),
        ),
        _buildDeleteSubjectCard(
          onTap: () => showDialog(
            context: context,
            builder: (_) => DeleteCourseDialog(
              controller: controller,
              courseName: initializedState.course.name,
              courseId: initializedState.course.id,
            ),
          ),
        )
      ],
    );
  }

  Card _buildOptionCard(
      {required bool isSelected,
      required int pageNo,
      required String text,
      required IconData icon,
      Key? iconKey}) {
    return Card(
      elevation: 2,
      color: isSelected
          ? Colors.grey[200]!.withOpacity(.9)
          : const Color.fromARGB(255, 255, 255, 255),
      child: ListTile(
        onTap: () {
          if (!isSelected)
            setState(() {
              _pageController.animateToPage(
                pageNo,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
              _currentPage = pageNo;
            });
        },
        leading: Icon(
          icon,
          color: Colors.blue,
          key: iconKey,
        ),
        minLeadingWidth: 10,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Material(
            color: Colors.transparent,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditSubjectCard({required Function() onTap}) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.edit_outlined, color: Colors.blue),
        minLeadingWidth: 10,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "Edit Subject",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteSubjectCard({required Function() onTap}) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.delete_outline, color: Colors.red),
        minLeadingWidth: 10,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            "Delete Subject",
            style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

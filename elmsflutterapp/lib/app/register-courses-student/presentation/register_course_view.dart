import 'dart:js';

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register_course_controller.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register_course_state_machine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;

class RegisterCourseViewPage extends fa.View {
  @override
  State<StatefulWidget> createState() => RegisterCourseViewPageState();
}

class RegisterCourseViewPageState extends fa
    .ResponsiveViewState<RegisterCourseViewPage, RegisterCourseController> {
  RegisterCourseViewPageState() : super(RegisterCourseController());

  @override
  Widget get desktopView =>
      fa.ControlledWidgetBuilder<RegisterCourseController>(
          builder: (context, controller) {
        final currentState = controller.getCurrentState();
        final currentStateType = controller.getCurrentState().runtimeType;
        print(
          "buildDesktopView called with state $currentStateType",
        );

        switch (currentStateType) {
          case RegisterCoursePageInitializationState:
            return buildInitializationStateViewWeb(controller);

          case RegisterCoursePageInitializedState:
            RegisterCoursePageInitializedState initializedState =
                currentState as RegisterCoursePageInitializedState;
            return buildInitializedStateViewWeb(
                context, controller, initializedState);

          case RegisterCoursePageErrorState:
            return _buildErrorStateView("Error fetching data");

          case RegisterCourseLoadingState:
            return buildLoadingState(controller);
        }
        throw Exception("Unrecognized state $currentStateType encountered");
      });

  @override
  Widget get mobileView => desktopView;

  @override
  Widget get tabletView => mobileView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget buildInitializationStateViewWeb(RegisterCourseController controller) {
    controller.initializeScreen();
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildLoadingState(RegisterCourseController controller) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorStateView(String error) {
    return Scaffold(
        key: globalKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ));
  }

  Widget buildInitializedStateViewWeb(
      BuildContext context,
      RegisterCourseController controller,
      RegisterCoursePageInitializedState state) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: 'refresh-subjects-tab',
          tooltip: 'Refresh',
          child: const Icon(
            Icons.refresh,
            size: 35,
            color: Colors.blue,
          ),
          onPressed: () {
            controller.refreshPage();
          }),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30,
                            childAspectRatio: 1),
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      return _buildSubjectCard(
                          context, controller, state.courses[index], index);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Color> get subjectCardColors => [
      Colors.black87.withOpacity(0.7),
      Colors.blue.withOpacity(0.7),
      Colors.green.withOpacity(0.7),
      Colors.amber.withOpacity(0.7),
    ];

Widget _buildSubjectCard(BuildContext context,
    RegisterCourseController controller, CourseEntity course, int index) {
  showAlertDialogToEnrollToCourse(
      BuildContext context, String courseId, String courseName) {
    Widget cancelButton = TextButton(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: const Text("No",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w200,
                color: Color(0xFFFF4081),
                fontFamily: 'Ubuntu')),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          decoration: BoxDecoration(
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
          ),
          child: const Text("Yes",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                  fontFamily: 'Ubuntu'))),
      onPressed: () {
        controller.enrollToCourse(courseId: courseId);
      },
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text("Enroll To Course",
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w400,
              fontSize: 25,
              fontFamily: "Ubuntu")),
      content: Text(
          "Are you sure you want to enroll to this course '$courseName' ?",
          style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 15,
              fontFamily: "UbuntuRegular",
              fontWeight: FontWeight.w400)),
      actions: [
        cancelButton,
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  return GestureDetector(
    onTap: () =>
        {showAlertDialogToEnrollToCourse(context, course.id, course.name)},
    child: Card(
      elevation: 6,
      color: subjectCardColors[index % 4],
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                course.courseCode,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(4),
              child: Text(
                course.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.center,
              child: Text(
                "Enroll to course",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

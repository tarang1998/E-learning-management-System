import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/instructor-courses/presentation/instructor_courses_controller.dart';
import 'package:elmsflutterapp/app/instructor-courses/presentation/instructor_courses_state_machine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;

class InstructorCoursesViewPage extends fa.View {
  @override
  State<StatefulWidget> createState() => InstructorCoursesViewPageState();
}

class InstructorCoursesViewPageState extends fa.ResponsiveViewState<
    InstructorCoursesViewPage, InstructorCoursesController> {
  InstructorCoursesViewPageState() : super(InstructorCoursesController());

  @override
  Widget get desktopView =>
      fa.ControlledWidgetBuilder<InstructorCoursesController>(
          builder: (context, controller) {
        final currentState = controller.getCurrentState();
        final currentStateType = controller.getCurrentState().runtimeType;
        print(
          "buildDesktopView called with state $currentStateType",
        );

        switch (currentStateType) {
          case InstructorCoursesPageInitializationState:
            return buildInitializationStateViewWeb(controller);

          case InstructorCoursesPageInitializedState:
            InstructorCoursesPageInitializedState initializedState =
                currentState as InstructorCoursesPageInitializedState;
            return buildInitializedStateViewWeb(controller, initializedState);

          case InstructorCoursesPageErrorState:
            return _buildErrorStateView("Error fetching data");
        }
        throw Exception("Unrecognized state $currentStateType encountered");
      });

  @override
  Widget get mobileView => desktopView;

  @override
  Widget get tabletView => mobileView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget buildInitializationStateViewWeb(
      InstructorCoursesController controller) {
    controller.initializeScreen();
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

  Widget buildInitializedStateViewWeb(InstructorCoursesController controller,
      InstructorCoursesPageInitializedState state) {
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
                          controller, state.courses[index], index);
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
Widget _buildSubjectCard(
    InstructorCoursesController controller, CourseEntity course, int index) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => {controller.navigateToSubjectDetailsPage(courseId: course.id)},
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
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(
                  "Go to course",
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
    ),
  );
}

// Import statements for the required packages and classes
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_controller.dart';
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_state_machine.dart';
import 'package:elmsflutterapp/app/all-courses-admin/presentation/widget/add_subject_dialogue.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fa;

// Class definition for the AllCoursesViewPage, extending the fa.View class
class AllCoursesViewPage extends fa.View {
  @override
  State<StatefulWidget> createState() => AllCoursesViewPageState();
}

// Class definition for the AllCoursesViewPageState, extending ResponsiveViewState
class AllCoursesViewPageState
    extends fa.ResponsiveViewState<AllCoursesViewPage, AllCoursesController> {
  // Constructor initializing the state with an instance of AllCoursesController
  AllCoursesViewPageState() : super(AllCoursesController());

  // Override method to build the desktop view
  @override
  Widget get desktopView => fa.ControlledWidgetBuilder<AllCoursesController>(
          builder: (context, controller) {
        // Obtain the current state and its type for debugging
        final currentState = controller.getCurrentState();
        final currentStateType = controller.getCurrentState().runtimeType;
        print(
          "buildDesktopView called with state $currentStateType",
        );

        // Switch statement to handle different states and return the corresponding view
        switch (currentStateType) {
          case AllCoursesPageInitializationState:
            return buildInitializationStateViewWeb(controller);

          case AllCoursesPageInitializedState:
            AllCoursesPageInitializedState initializedState =
                currentState as AllCoursesPageInitializedState;
            return buildInitializedStateViewWeb(controller, initializedState);

          case AllCoursesPageLoadingState:
            return loadingState(controller);

          case AllCoursesPageErrorState:
            return _buildErrorStateView("Error fetching data");
        }
        throw Exception("Unrecognized state $currentStateType encountered");
      });

  // Override method to return the mobile view
  @override
  Widget get mobileView => desktopView;

  // Override method to return the tablet view
  @override
  Widget get tabletView => mobileView;

  // Override method (not implemented) for watch view
  @override
  Widget get watchView => throw UnimplementedError();

  // Method to build the view for the initialization state on the web
  Widget buildInitializationStateViewWeb(AllCoursesController controller) {
    controller.initializeScreen();
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  // Method to build the loading state view
  Widget loadingState(AllCoursesController controller) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  // Method to build the error state view
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

  // Method to build the view for the initialized state on the web
  Widget buildInitializedStateViewWeb(
      AllCoursesController controller, AllCoursesPageInitializedState state) {
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
                    itemCount: state.courses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0)
                        return buildAddSubjectCard(context, controller);
                      return _buildSubjectCard(
                          controller, state.courses[index - 1], index);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Method to build the card for adding a new subject
Widget buildAddSubjectCard(
  BuildContext context,
  AllCoursesController controller,
) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (_) => AddSubjectDialog(
              onBack: controller.handleBackEvent,
              onAdd: (subjectName, subjectCode, subjectDescription) {
                controller.addCourse(
                    courseName: subjectName,
                    courseCode: subjectCode,
                    courseDescription: subjectDescription);
              }));
    },
    child: Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.blue, width: 2.5)),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 15),
            Text(
              "Add Course",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// List of colors for the subject cards
List<Color> get subjectCardColors => [
      Colors.black87.withOpacity(0.7),
      Colors.blue.withOpacity(0.7),
      Colors.green.withOpacity(0.7),
      Colors.amber.withOpacity(0.7),
    ];

// Method to build a subject card
Widget _buildSubjectCard(
    AllCoursesController controller, CourseEntity course, int index) {
  return GestureDetector(
    onTap: () => {},
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
                  color: Colors.red
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
  );
}
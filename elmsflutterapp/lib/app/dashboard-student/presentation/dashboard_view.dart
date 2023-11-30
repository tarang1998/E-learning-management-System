// Importing necessary packages and classes
import 'package:elmsflutterapp/app/dashboard-student/presentation/dashboard_controller.dart';
import 'package:elmsflutterapp/app/dashboard-student/presentation/dashboard_state_machine.dart';
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fa;

// Class definition for the DashboardViewPage extending fa.View
class DashboardViewPage extends fa.View {
  @override
  State<StatefulWidget> createState() => DashboardViewPageState();
}

// Class definition for the DashboardViewPageState extending fa.ResponsiveViewState
class DashboardViewPageState extends fa.ResponsiveViewState<DashboardViewPage, DashboardController> {
  // Constructor initializing the state with the DashboardController
  DashboardViewPageState() : super(DashboardController());

  // Override to provide the desktop view
  @override
  Widget get desktopView => fa.ControlledWidgetBuilder<DashboardController>(
          builder: (context, controller) {
        // Retrieving the current state and its type
        final currentState = controller.getCurrentState();
        final currentStateType = controller.getCurrentState().runtimeType;

        // Logging the current state type
        print(
          "buildDesktopView called with state $currentStateType",
        );

        // Switching based on the state type to build the appropriate view
        switch (currentStateType) {
          case DashboardPageInitializationState:
            return buildInitializationStateViewWeb(controller);

          case DashboardPageInitializedState:
            DashboardPageInitializedState initializedState =
                currentState as DashboardPageInitializedState;
            return buildInitializedStateViewWeb(controller, initializedState);

          case DashboardPageErrorState:
            return _buildErrorStateView("Error fetching data");
        }
        
        // Throwing an exception for unrecognized state type
        throw Exception("Unrecognized state $currentStateType encountered");
      });

  // Override to provide the mobile view
  @override
  Widget get mobileView => desktopView;

  // Override to provide the tablet view
  @override
  Widget get tabletView => mobileView;

  // Override to provide the watch view (not implemented)
  @override
  Widget get watchView => throw UnimplementedError();

  // Method to build the view for the initialization state on web
  Widget buildInitializationStateViewWeb(DashboardController controller) {
    // Triggering the initialization of the screen
    controller.initializeScreen();
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  // Method to build the error state view with a given error message
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

  // Method to build the view for the initialized state on web
  Widget buildInitializedStateViewWeb(
      DashboardController controller, DashboardPageInitializedState state) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            heroTag: 'refresh-subjects-tab',
            tooltip: 'Refresh',
            child: const Icon(
              Icons.refresh,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () {
              controller.refreshPage();
            }),
        body: (state.courses.length != 0)
            ? Container(
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
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You haven't registered for any courses yet!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}

// List of colors for the subject card
List<Color> get subjectCardColors => [
      Colors.black87.withOpacity(0.7),
      Colors.blue.withOpacity(0.7),
      Colors.green.withOpacity(0.7),
      Colors.amber.withOpacity(0.7),
    ];

// Method to build the subject card for a course
Widget _buildSubjectCard(
    DashboardController controller, CourseEntity course, int index) {
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
                  color: Colors.red, borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.center,
              child: Text(
                "Go To Course",
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

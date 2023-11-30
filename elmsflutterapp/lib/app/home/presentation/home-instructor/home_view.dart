// Importing necessary packages and classes
import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses.dart';
import 'package:elmsflutterapp/app/home/presentation/widgets/web_navigation_tab.dart';
import 'package:elmsflutterapp/app/instructor-courses/presentation/instructor_courses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fa;

// Importing the home controller and state machine
import 'home_controller.dart';
import 'home_state_machine.dart';

// View class for the instructor's home page
class HomepageInstructor extends fa.View {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

// State class for the instructor's home page view
class HomeViewState extends fa.ResponsiveViewState<HomepageInstructor, HomePageInstructorController> {
  HomeViewState() : super(new HomePageInstructorController());

  @override
  void dispose() {
    super.dispose();
  }

  // Method to build the desktop view of the home page
  @override
  Widget get desktopView => mobileView;

  // Method to build the mobile view of the home page
  @override
  Widget get mobileView => fa.ControlledWidgetBuilder<HomePageInstructorController>(
        builder: (context, controller) {
          // Getting the current state and type of the state
          final currentState = controller.getCurrentState();
          final currentStateType = controller.getCurrentState().runtimeType;
          print("buildMobileView called with state $currentStateType");

          // Switching based on the type of the current state
          switch (currentStateType) {
            // Handling the initialization state of the home page
            case HomePageInstructorInitializationState:
              return _buildLoadingStateView(controller);

            // Handling the initialized state of the home page
            case HomePageInstructorInitState:
              HomePageInstructorInitState homePageInitState =
                  currentState as HomePageInstructorInitState;
              return _buildInitialStateView(homePageInitState, controller);

            // Handling the error state of the home page
            case HomePageInstructorErrorState:
              HomePageInstructorErrorState errorState =
                  currentState as HomePageInstructorErrorState;
              return _buildErrorStateView(errorState.errorMessage);
          }
          throw Exception("Unrecognized state $currentStateType encountered");
        },
      );

  @override
  Widget get tabletView => mobileView; // View same as mobile

  @override
  Widget get watchView => throw UnimplementedError();

  // Method to build the loading state view of the home page
  Widget _buildLoadingStateView(HomePageInstructorController controller) {
    controller.initializePage();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Method to build the initialized state view of the home page
  Widget _buildInitialStateView(HomePageInstructorInitState initState, HomePageInstructorController controller) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.white,
        leadingWidth: 450,
        leading: profileContainer(
          studentName: initState.instructorData.name,
          controller: controller,
        ),
        actions: [
          _buildNavTab(
              title: "Your Courses",
              controller: controller,
              initializedState: initState,
              pageNo: 0,
              icon: Icons.book_sharp,
              onChange: () => {
                controller.handlePageChange(initState.instructorData, 0)
              }),
          if (initState.instructorData.roles.contains("ADMIN"))
            _buildNavTab(
                title: "All Courses",
                controller: controller,
                initializedState: initState,
                pageNo: 1,
                icon: Icons.all_inbox,
                onChange: () => {
                  controller.handlePageChange(initState.instructorData, 1)
                }),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: initState.page,
          children: <Widget>[
            InstructorCoursesViewPage(),
            if (initState.instructorData.roles.contains("ADMIN"))
              AllCoursesViewPage()
          ],
        ),
      ),
    );
  }

  // Method to build the profile container widget
  Widget profileContainer({
    required HomePageInstructorController controller,
    required String studentName,
  }) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          const BoxShadow(color: Colors.white),
        ],
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    controller.navigateToProfilePage();
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.5),
                            blurRadius: 10.0,
                          )
                        ]),
                    child: const Icon(
                      Icons.person_outline,
                      size: 35,
                      color: Color(0xFF747C80),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                  onTap: () {
                    controller.navigateToProfilePage();
                  },
                  child: Text(
                      'Hello' + ",  " + studentName + '\n' + "Welcome Back! ",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontFamily: "Ubuntu")),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Method to build the navigation tab widget
  Widget _buildNavTab({
    required HomePageInstructorController controller,
    required HomePageInstructorInitState initializedState,
    required String title,
    required int pageNo,
    required IconData icon,
    required Function() onChange,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onChange,
            child: WebNavigationTabs(
              condition: initializedState.page == pageNo,
              title: title,
              icon: icon,
            ),
          ),
        ),
      ),
    );
  }

  // Method to build the error state view of the home page
  Widget _buildErrorStateView(String error) {
    return Scaffold(
        key: globalKey,
        body: Column(
          children: <Widget>[
            Text(
              error,
              style: TextStyle(
                color: Colors.red,
              ),
            )
          ],
        ));
  }
}


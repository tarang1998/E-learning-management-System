import 'package:elmsflutterapp/app/dashboard-student/presentation/dashboard_view.dart';
import 'package:elmsflutterapp/app/home/presentation/widgets/web_navigation_tab.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register_course_view.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;
import 'home_controller.dart';
import 'home_state_machine.dart';

class HomePageStudent extends fa.View {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState
    extends fa.ResponsiveViewState<HomePageStudent, HomePageStudentController> {
  HomeViewState() : super(HomePageStudentController());

  @override
  void dispose() {
    // Hive.close();
    super.dispose();
  }

  @override
  Widget get desktopView => mobileView;

  @override
  Widget get mobileView =>
      fa.ControlledWidgetBuilder<HomePageStudentController>(
        builder: (context, controller) {
          final currentState = controller.getCurrentState();
          final currentStateType = controller.getCurrentState().runtimeType;
          print("buildMobileView called with state $currentStateType");

          switch (currentStateType) {
            case HomePageStudentLoadingState:
              return _buildLoadingStateView(controller);

            case HomePageStudentInitState:
              HomePageStudentInitState homePageInitState =
                  currentState as HomePageStudentInitState;
              return _buildInitialStateView(homePageInitState, controller);

            case HomePageStudentErrorState:
              HomePageStudentErrorState errorState =
                  currentState as HomePageStudentErrorState;
              return _buildErrorStateView(errorState.errorMessage);
          }
          throw Exception("Unrecognized state $currentStateType encountered");
        },
      );

  @override
  Widget get tabletView => mobileView; // View same as mobile

  @override
  Widget get watchView => throw UnimplementedError();

  Widget _buildInitialStateView(HomePageStudentInitState initState,
      HomePageStudentController controller) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.white,
        leadingWidth: 450,
        leading: profileContainer(
          studentName: initState.studentData.name,
          controller: controller,
        ),
        actions: [
          _buildNavTab(
              title: "Dashboard",
              controller: controller,
              initializedState: initState,
              pageNo: 0,
              icon: Icons.dashboard,
              onChange: () =>
                  {controller.handlePageChange(initState.studentData, 0)}),
          _buildNavTab(
              title: "Explore Courses",
              controller: controller,
              initializedState: initState,
              pageNo: 1,
              icon: Icons.app_registration,
              onChange: () =>
                  {controller.handlePageChange(initState.studentData, 1)}),
          _buildNavTab(
              title: "Contact Support",
              controller: controller,
              initializedState: initState,
              pageNo: 99,
              icon: Icons.support_agent,
              onChange: () => {controller.handleContactSupportButtonClicked()}),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: initState.page,
          children: <Widget>[
            DashboardViewPage(),
            RegisterCourseViewPage(),
          ],
        ),
      ),
    );
  }

  Widget profileContainer({
    required HomePageStudentController controller,
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
                      'Hello' +
                          ",  " +
                          studentName +
                          '\n' +
                          "Welcome! " +
                          
                          "It's a good time to learn a language.",
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

  Widget _buildNavTab({
    required HomePageStudentController controller,
    required HomePageStudentInitState initializedState,
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

  Widget _buildLoadingStateView(HomePageStudentController controller) {
    controller.initializeHomeScreen();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
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

}

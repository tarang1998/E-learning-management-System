import 'package:elmsflutterapp/app/dashboard/presentation/dashboardView.dart';
import 'package:elmsflutterapp/app/home/presentation/widgets/web_navigation_tab.dart';
import 'package:elmsflutterapp/app/register-courses/presentation/register_course_view.dart';
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
        leadingWidth: 330,
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
            DashboardPage(),
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
                    width: 50,
                    height: 50,
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
                  child: Text('Hello' + ",  " + studentName + '\n' + "Welcome!",
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

  // Widget _examsContentBody() => ExamDashBoardPage();

  // Widget _profileContainer(String name, HomePageController controller) {
  //   return Container(
  //     key: Key(Keys.homeProfileContainer),
  //     height: 100,
  //     decoration: AppTheme.profileContainer,
  //     child: Row(
  //       children: <Widget>[
  //         GestureDetector(
  //           onTap: () {
  //             controller.navigateToProfilePage();
  //           },
  //           child: Container(
  //             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  //             width: 50,
  //             height: 50,
  //             decoration: AppTheme.boxDecorationCircularFrame,
  //             child: Icon(
  //               Icons.person_outline,
  //               size: 35,
  //               color: Color(0xFF747C80),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: GestureDetector(
  //               onTap: () {
  //                 controller.navigateToProfilePage();
  //               },
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     AppLocalizations.instance.translate("home.label.hi") +
  //                         name,
  //                     style: AppTheme.textStylePrimaryText,
  //                     overflow: TextOverflow.fade,
  //                     maxLines: 1,
  //                     softWrap: false,
  //                   ),
  //                   Text(
  //                     AppLocalizations.instance.translate("home.label.welcome"),
  //                     style: AppTheme.textStylePrimaryText,
  //                   )
  //                 ],
  //               )),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             controller.handleContactSupportButtonClicked();
  //           },
  //           child: Container(
  //             padding: EdgeInsets.only(right: 10),
  //             child: Text(
  //               AppLocalizations.instance
  //                   .translate('profile.header.text.contact_us'),
  //               style: AppTheme.textContactUs,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _bottomNavigationBar(
  //     HomePageInitState initState, HomePageController controller) {
  //   return BottomNavigationBar(
  //     unselectedIconTheme: IconThemeData(color: Colors.grey, size: 28),
  //     selectedIconTheme: IconThemeData(color: AppTheme.primaryColor, size: 30),
  //     selectedLabelStyle: TextStyle(color: AppTheme.primaryColor),
  //     unselectedLabelStyle: TextStyle(color: Colors.grey),
  //     backgroundColor: Colors.white,
  //     items: [
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.import_contacts,
  //         ),
  //         label: AppLocalizations.instance.translate("home.label.exams"),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(
  //           Icons.subject,
  //           key: Key(Keys.homeScreenPerformanceTab),
  //         ),
  //         label: AppLocalizations.instance.translate("home.label.performance"),
  //       ),
  //     ],
  //     currentIndex: initState.page,
  //     onTap: (int _page) {
  //       controller.handleBottomBarPageRoute(_page);
  //     },
  //   );
  // }

  // Widget _resultsPage() {
  //   return ResultsMainPage(
  //     shouldHideResults: FeatureFlagsConfig.instance!.features
  //         .contains(FeatureFlags.HIDE_RESULTS),
  //   );
  // }
}

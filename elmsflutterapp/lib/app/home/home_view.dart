import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fa;
import 'home_controller.dart';
import 'home_state_machine.dart';

class HomePage extends fa.View {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends fa.ResponsiveViewState<HomePage, HomePageController> {
  HomeViewState() : super(new HomePageController());

  @override
  void dispose() {
    // Hive.close();
    super.dispose();
  }

  @override
  Widget get desktopView => throw UnimplementedError();

  @override
  Widget get mobileView => fa.ControlledWidgetBuilder<HomePageController>(
        builder: (context, controller) {
          final currentState = controller.getCurrentState();
          final currentStateType = controller.getCurrentState().runtimeType;
          print("buildMobileView called with state $currentStateType");

          switch (currentStateType) {
            // case HomePageInitState:
            //   HomePageInitState homePageInitState =
            //       currentState as HomePageInitState;
            //   return _buildInitialStateView(homePageInitState, controller);

            case HomePageLoadingState:
              return _buildLoadingStateView(controller);

            // case HomePageErrorState:
            //   HomePageErrorState errorState =
            //       currentState as HomePageErrorState;
              // return _buildErrorStateView(errorState.errorMessage);
          }
          throw Exception("Unrecognized state $currentStateType encountered");
        },
      );

  @override
  Widget get tabletView => mobileView; // View same as mobile

  @override
  Widget get watchView => throw UnimplementedError();

  // Widget _buildInitialStateView(
  //     HomePageInitState initState, HomePageController controller) {
  //   return Scaffold(
  //     key: globalKey,
  //     body: SafeArea(
  //       child: Column(
  //         children: <Widget>[
  //           _profileContainer(initState.profile!.userName, controller),
  //           Expanded(
  //             child: initState.page == 0 ? _examsContentBody() : _resultsPage(),
  //           ),
  //         ],
  //       ),
  //     ),
  //     bottomNavigationBar: _bottomNavigationBar(initState, controller),
  //   );
  // }

  Widget _buildLoadingStateView(HomePageController controller) {
    // controller.getProfileInfo();
    return Scaffold(
        key: globalKey,
        body: Text("Home")
        // Shimmer.fromColors(
        //   baseColor: Colors.grey[300]!,
        //   highlightColor: Colors.grey[100]!,
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         margin: EdgeInsets.all(10),
        //         width: double.infinity,
        //         height: 100,
        //         decoration: AppTheme.boxDecorationGreyColor,
        //       ),
        //       Container(
        //         margin: EdgeInsets.all(10),
        //         height: 100,
        //         child: ListView.builder(
        //             scrollDirection: Axis.horizontal,
        //             itemCount: 3,
        //             itemBuilder: (context, index) {
        //               return Container(
        //                 margin: EdgeInsets.symmetric(horizontal: 10),
        //                 height: 100,
        //                 width: 150,
        //                 //decoration:AppTheme.boxDecorationGreyColor
        //               );
        //             }),
        //       ),
        //       Container(
        //         margin: EdgeInsets.all(10),
        //         height: 50,
        //         width: double.infinity,
        //       ),
        //       Container(
        //         height: 350,
        //         child: ListView.builder(
        //             itemCount: 3,
        //             itemBuilder: (context, index) {
        //               return Container(
        //                 margin: EdgeInsets.all(10),
        //                 height: 100,
        //                 width: double.infinity,
        //                 //decoration: AppTheme.boxDecorationGreyColor
        //               );
        //             }),
        //       )
        //     ],
        //   ),
        //)
        
        );
  }

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

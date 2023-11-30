import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'profile_page_controller.dart';
import 'profile_page_state_machine.dart';

class ProfilePage extends fa.View {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState
    extends fa.ResponsiveViewState<ProfilePage, ProfilePageController> {
  ProfilePageState() : super(ProfilePageController());

  @override
  Widget get desktopView => fa.ControlledWidgetBuilder<ProfilePageController>(
          builder: (context, controller) {
        final currentState = controller.getCurrentState();
        final currentStateType = controller.getCurrentState().runtimeType;

        switch (currentStateType) {
          case ProfilePageInitState:
            return _buildInitState(controller);

          case ProfilePageInitializedState:
            ProfilePageInitializedState initializedState =
                currentState as ProfilePageInitializedState;
            return _buildInitializedStateView(controller);

          case ProfilePageLoadingState:
            return _buildLoadingStateView(controller);

          case ProfilePageErrorState:
            return _buildErrorStateView('An error has occured', controller);
        }
        throw Exception("Unrecognized state $currentStateType encountered");
      });

  @override
  Widget get mobileView => desktopView;

  @override
  Widget get tabletView => desktopView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget _buildInitState(ProfilePageController controller) {
    controller.getUserData();
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildInitializedStateView(ProfilePageController controller) {
    return _contentBody(controller);
  }

  Widget _buildErrorStateView(String error, ProfilePageController controller) {
    return Scaffold(
      key: globalKey,
      body: Column(
        children: <Widget>[
          _contentBody(controller),
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }

  Widget _buildLoadingStateView(ProfilePageController controller) {
    return Scaffold(
      key: globalKey,
      body:
          ModalProgressHUD(inAsyncCall: true, child: _contentBody(controller)),
    );
  }

  Widget _contentBody(
    ProfilePageController controller,
  ) {
    showAlertDialog(BuildContext context) {
      Widget cancelButton = TextButton(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
          child: const Text("Cancel",
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
            child: const Text("Log out",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                    fontFamily: 'Ubuntu'))),
        onPressed: () {
          controller.signout();
        },
      );
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Text("Log Out",
            style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.w400,
                fontSize: 25,
                fontFamily: "Ubuntu")),
        content: const Text("Are you sure that you want to Log out ?",
            style: TextStyle(
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

    return Scaffold(
      floatingActionButton: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            showAlertDialog(context);
          },
          child: Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(30, 20, 0, 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
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
            child: Center(
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.teal[400],
                    size: 32,
                  ),
                  onPressed: () {
                    controller.handleBackButtonClick();
                  }),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300]!,
                          offset: const Offset(2, 2),
                          spreadRadius: 1,
                          blurRadius: 10)
                    ]),
                child: const Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text("Name" + ": ${controller.staffName}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF747C80),
                      fontFamily: "Ubuntu")),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                controller.resetPassword(controller.staffName, context);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  
                  child: Center(
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontFamily: "Ubuntu",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

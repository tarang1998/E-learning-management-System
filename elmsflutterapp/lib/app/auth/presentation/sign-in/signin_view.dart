// Import necessary packages and files
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fa;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'signin_controller.dart';
import 'signin_state_machine.dart';
import 'widgets/loginPage.dart';

// Define the SignInPage class extending fa.View
class SignInPage extends fa.View {
  @override
  State<StatefulWidget> createState() => SignInViewState();
}

// Define the SignInViewState class extending fa.ResponsiveViewState
class SignInViewState
    extends fa.ResponsiveViewState<SignInPage, SigninController> {
  SignInViewState() : super(SigninController());

  SizeConfig? sizeConfig;

  // Getter for desktop view
  @override
  Widget get desktopView => mobileView;

  // Getter for mobile view
  @override
  Widget get mobileView => fa.ControlledWidgetBuilder<SigninController>(
        builder: (context, controller) {
          sizeConfig = SizeConfig.getInstance(context);
          final currentStateType = controller.getCurrentState().runtimeType;
          print("buildMobileView called with state $currentStateType");

          // Switch statement to handle different view states
          switch (currentStateType) {
            case SignInInitState:
              return _buildInitialStateView(controller);

            case SignInLoadingState:
              return _buildLoadingStateView(controller);
          }
          throw Exception("Unrecognized state $currentStateType encountered");
        },
      );

  // Getter for tablet view
  @override
  Widget get tabletView => mobileView;

  // Getter for watch view (not implemented)
  @override
  Widget get watchView => throw UnimplementedError();

  // Function to build the view for the initial state
  Widget _buildInitialStateView(SigninController controller) {
    return Scaffold(
      key: globalKey,
      body: SignInScreen(controller: controller),
    );
  }

  // Function to build the view for the loading state
  Widget _buildLoadingStateView(SigninController controller) {
    return Scaffold(
      key: globalKey,
      body: ModalProgressHUD(
        inAsyncCall: true,
        child: SignInScreen(controller: controller),
      ),
    );
  }
}

import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as fa;
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'signin_controller.dart';
import 'signin_state_machine.dart';
import 'widgets/loginPage.dart';

class SignInPage extends fa.View {
  @override
  State<StatefulWidget> createState() => SignInViewState();
}

class SignInViewState
    extends fa.ResponsiveViewState<SignInPage, SigninController> {
  SignInViewState() : super(SigninController());

  SizeConfig? sizeConfig;

  @override
  Widget get desktopView => mobileView;

  @override
  Widget get mobileView => fa.ControlledWidgetBuilder<SigninController>(
        builder: (context, controller) {
          sizeConfig = SizeConfig.getInstance(context);
          final currentStateType = controller.getCurrentState().runtimeType;
          print("buildMobileView called with state $currentStateType");

          switch (currentStateType) {
            case SignInInitState:
              return _buildInitialStateView(controller);

            case SignInLoadingState:
              return _buildLoadingStateView(controller);
          }
          throw Exception("Unrecognized state $currentStateType encountered");
        },
      );

  @override
  Widget get tabletView => mobileView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget _buildInitialStateView(SigninController controller) {
    return Scaffold(
      key: globalKey,
      body: SignInScreen(controller: controller),
    );
  }

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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fca;
import 'splash_controller.dart';
import 'splash_state_machine.dart';

class SplashPage extends fca.View {
  @override
  State<StatefulWidget> createState() => SplashViewState();
}

class SplashViewState
    extends fca.ResponsiveViewState<SplashPage, SplashController> {
  SplashViewState() : super(new SplashController());

  @override
  Widget get desktopView => mobileView;

  @override
  Widget get mobileView => fca.ControlledWidgetBuilder<SplashController>(
        builder: (context, controller) {
          final currentState = controller.getCurrentState();
          final currentStateType = controller.getCurrentState().runtimeType;
          print("buildMobileView called with state $currentStateType");

          switch (currentStateType) {
            case SplashInitState:
              return _buildSplashScreen(controller);
          }
          throw Exception("Unrecognized state $currentStateType encountered");
        },
      );

  @override
  Widget get tabletView => mobileView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget _buildSplashScreen(SplashController controller) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1),
          () => {controller.checkIfUserIsLoggedIn()});
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset(
          'assets/animations/splash.gif',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

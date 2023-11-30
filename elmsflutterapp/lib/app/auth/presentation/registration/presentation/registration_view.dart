import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:elmsflutterapp/utils/validate_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;
import 'package:fluttertoast/fluttertoast.dart';
import 'registration_controller.dart';
import 'registration_state_machine.dart';

class RegistrationPage extends fa.View {
  @override
  State<StatefulWidget> createState() => RegistrationViewState();
}

class RegistrationViewState extends fa
    .ResponsiveViewState<RegistrationPage, RegistrationPageController> {
  RegistrationViewState() : super(RegistrationPageController()) {}

  @override
  Widget get desktopView =>
      fa.ControlledWidgetBuilder<RegistrationPageController>(
          builder: (context, controller) {
        final currentState = controller.getCurrentState();
        final currentStateType = controller.getCurrentState().runtimeType;

        switch (currentStateType) {
          case RegistrationPageInitializedState:
            RegistrationPageInitializedState? initializedState =
                currentState as RegistrationPageInitializedState?;
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/SBLogo.png',
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Student Registration",
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontFamily: "Ubuntu"
                                  //fontFamily: "ubuntu"
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: controller.studentName,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (newValue) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: const OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE7E9E9)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFFB9BDBF),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: controller.studentEmail,
                                onChanged: (newValue) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: const OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE7E9E9)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFFB9BDBF),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: controller.passwordText,
                                obscureText: controller.obscurePassword,
                                onChanged: (newValue) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: !controller.obscurePassword
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.obscurePassword =
                                            !controller.obscurePassword;
                                      });
                                    },
                                  ),
                                  hintText: 'Password',
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: const OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE7E9E9)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFFB9BDBF),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: controller.confirmPasswordText,
                                obscureText:
                                    controller.obscureConfirmedPassword,
                                onChanged: (newValue) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color:
                                          !controller.obscureConfirmedPassword
                                              ? Colors.blue
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.obscureConfirmedPassword =
                                            !controller
                                                .obscureConfirmedPassword;
                                      });
                                    },
                                  ),
                                  hintText: 'Confirm Password',
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: const OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE7E9E9)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFFB9BDBF),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      controller.navigateToLoginPage();
                                    },
                                    child: Text(
                                      "Login",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: getScreenHeight(context) * 0.05),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  if (controller.checkIfAllFieldsAreFilled()) {
                                    if (!controller.checkIfPasswordsMatch()) {
                                      Fluttertoast.showToast(
                                          msg: "Passwords do not match");
                                      return;
                                    }
                                    if (!EmailValidator.validate(
                                        controller.studentEmail.text)) {
                                      Fluttertoast.showToast(
                                          msg: "Please enter a valid email");
                                      return;
                                    }
                                    controller.submitForRegistration();
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: controller
                                              .checkIfAllFieldsAreFilled() &&
                                          controller.checkIfPasswordsMatch() &&
                                          EmailValidator.validate(
                                              controller.studentEmail.text)
                                      ? BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
                                              blurRadius: 40.0,
                                              spreadRadius: 0.0,
                                              offset: const Offset(
                                                0.0,
                                                0.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      : BoxDecoration(
                                          color: const Color(0xFFD1D3D5),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
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
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white,
                                          fontFamily: 'Ubuntu'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );

          case RegistrationPageLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case RegistrationPageErrorState:
            return Scaffold(
              key: globalKey,
              body: Column(
                children: <Widget>[
                  Text(
                    "Error",
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
            );
        }
        throw Exception("Unrecognized state $currentStateType encountered");
      });

  @override
  Widget get mobileView => desktopView;
  @override
  Widget get tabletView => mobileView;

  @override
  Widget get watchView => throw UnimplementedError();
}

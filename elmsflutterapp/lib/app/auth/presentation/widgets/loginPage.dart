import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import '../signin_controller.dart';
import 'forgot_password_dialog.dart';

class SignInScreen extends StatefulWidget {
  final SigninController controller;
  const SignInScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageBackground(context),
            _buildLoginFields(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginFields(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.03),
          const Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 0.5,
              fontSize: 25,
              fontFamily: 'Ubuntu',
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Container(
            height: 40,
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller.emailTextController,
              obscureText: false,
              onChanged: (val) => widget.controller.refreshPage(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-mail',
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 135, 136, 136)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 32, 33, 33)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB9BDBF),
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Ubuntu'),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: 40,
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller.passwordTextController,
              obscureText: !showPassword,
              onChanged: (val) => widget.controller.refreshPage(),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: showPassword ? Colors.black : Colors.grey,
                  ),
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
                hintText: 'Password',
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 135, 136, 136)),
                  borderRadius: BorderRadius.circular(10),
                ).copyWith(borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 32, 33, 33)),
                  borderRadius: BorderRadius.circular(10),
                ).copyWith(borderRadius: BorderRadius.circular(5)),
                hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB9BDBF),
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Ubuntu'),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Checkbox(
                      value: widget.controller.signInAsInstructor,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.controller.signInAsInstructor =
                              !widget.controller.signInAsInstructor!;
                        });
                      }),
                ),
                const Text(
                  "Sign in as a Instructor",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      color: Colors.black,
                      fontFamily: 'Ubuntu'),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                   // TODO : Implement Registeration Page 
                  },
                  child: Text(
                    "Register",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.controller.forgotPasswordClicked();
                    showDialog(
                      context: context,
                      builder: (_) =>
                          ForgotPasswordDialog(controller: widget.controller),
                    );
                  },
                  child: Text(
                    "Forgot Password",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          GestureDetector(
            onTap: () {
              if (widget.controller.emailTextController.text.isNotEmpty &&
                  widget.controller.passwordTextController.text.isNotEmpty)
                widget.controller.signinWithEmailAndPassword();
            },
            child: AnimatedContainer(
              height: 40,
              width: double.infinity,
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: widget.controller.emailTextController.text.isEmpty ||
                      widget.controller.passwordTextController.text.isEmpty
                  ? BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    )
                  : BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
              child: const Center(
                child: Text("Sign In",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontFamily: 'Ubuntu')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildImageBackground(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    final screenWidth = getScreenWidth(context);
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Image.asset(
            'assets/animations/exodus.gif',
            fit: BoxFit.cover,
            height: screenHeight * 0.45,
            width: screenWidth,
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/SBLogo.png',
                  height: 100,
                  color: Colors.white,
                ),
                const Text(
                  "SkillsBerg",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Ubuntu',
                    letterSpacing: 0.5,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 370,
            alignment: Alignment.center,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'SkillsBerg',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 36,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                FittedBox(
                  child: Text(
                    "The best place to learn new languages",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 0.5,
                      fontSize: 18,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

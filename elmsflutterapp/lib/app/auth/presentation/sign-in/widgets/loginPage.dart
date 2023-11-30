// Import necessary packages and files
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import '../signin_controller.dart';
import 'forgot_password_dialog.dart';

// Define the SignInScreen widget
class SignInScreen extends StatefulWidget {
  final SigninController controller;
  const SignInScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

// Define the state for the SignInScreen widget
class _SignInScreenState extends State<SignInScreen> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    // Build the main container for the SignInScreen
    return Container(
      height: getScreenHeight(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Build the image background section
            _buildImageBackground(context),
            
            // Build the login fields section
            _buildLoginFields(context),
          ],
        ),
      ),
    );
  }

  // Build the login fields section
  Widget _buildLoginFields(BuildContext context) {
    final screenHeight = getScreenHeight(context);

    // Build the container for login fields
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.03),
          
          // Build the "Login" text
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
          
          // Build the email text field
          Container(
            height: 40,
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller.emailTextController,
              obscureText: false,
              onChanged: (val) => widget.controller.refreshPage(),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                // Email input decoration
                hintText: 'E-mail',
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(),
                // Other border styles...
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          
          // Build the password text field
          Container(
            height: 40,
            width: double.infinity,
            child: TextFormField(
              controller: widget.controller.passwordTextController,
              obscureText: !showPassword,
              onChanged: (val) => widget.controller.refreshPage(),
              decoration: InputDecoration(
                // Password input decoration with eye icon for visibility
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
                // Other border styles...
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          
          // Build the checkbox for signing in as an instructor
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
                    },
                  ),
                ),
                const Text(
                  "Sign in as an Instructor",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                  ),
                ),
                Spacer(),
                
                // Build the "Register" button
                TextButton(
                  onPressed: () {
                    // TODO: Implement Registration Page
                  },
                  child: Text("Register"),
                ),
                
                // Build the "Forgot Password" button
                TextButton(
                  onPressed: () {
                    widget.controller.forgotPasswordClicked();
                    showDialog(
                      context: context,
                      builder: (_) => ForgotPasswordDialog(controller: widget.controller),
                    );
                  },
                  child: Text("Forgot Password"),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          
          // Build the "Sign In" button
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
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the image background section
  Container _buildImageBackground(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    final screenWidth = getScreenWidth(context);

    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/animations/exodus.gif',
            fit: BoxFit.cover,
            height: screenHeight * 0.45,
            width: screenWidth,
          ),
          
          // Logo and app name
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
          
          // Additional text and description
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

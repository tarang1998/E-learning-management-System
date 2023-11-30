// Importing the necessary Flutter packages.
import 'package:flutter/material.dart';

// Importing the SigninController for handling sign-in-related actions.
import '../signin_controller.dart';

// Defining a stateful widget for the Forgot Password dialog.
class ForgotPasswordDialog extends StatefulWidget {
  final SigninController controller;

  // Constructor that takes a SigninController instance.
  const ForgotPasswordDialog({Key? key, required this.controller}) : super(key: key);

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

// State class for the ForgotPasswordDialog.
class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  // Text editing controller for the email input field.
  final TextEditingController forgotPasswordEmailTextController = TextEditingController();
  
  // Global key for managing the state of the form.
  final _formKey = GlobalKey<FormState>();

  // Disposing of the text editing controller when the widget is disposed.
  @override
  void dispose() {
    forgotPasswordEmailTextController.dispose();
    super.dispose();
  }

  // Flag to track if the forgot password email field is empty.
  bool forgotPasswordEmailFieldEmpty = true;

  // Build method for constructing the UI of the dialog.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text("Reset Password"),
      content: Container(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 120),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              // Input field for entering the email.
              Container(
                height: 50,
                child: TextFormField(
                  autocorrect: true,
                  validator: (value) {
                    if (value!.isEmpty || forgotPasswordEmailFieldEmpty) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  controller: forgotPasswordEmailTextController,
                  obscureText: false,
                  onChanged: (val) => setState(() => forgotPasswordEmailFieldEmpty = val.trim().isEmpty),
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 135, 136, 136)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 32, 33, 33)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFFB9BDBF),
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Information text indicating that an email will be sent for password reset.
              const Text(
                "Check your email for resetting your password",
              ),
            ],
          ),
        ),
      ),
      actions: [
        // Cancel button widget.
        cancelButton,
        // OK button widget.
        okButton,
      ],
    );
  }

  // Widget for the Cancel button.
  Widget get cancelButton => TextButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text("CANCEL"),
    ),
    onPressed: () => Navigator.of(context).pop(),
  );

  // Widget for the OK button.
  Widget get okButton => TextButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Text("OKAY"),
    ),
    onPressed: () {
      // Checking if the email field is not empty and the form is valid.
      if (!forgotPasswordEmailFieldEmpty || _formKey.currentState!.validate()) {
        // Triggering the password reset request using the controller.
        widget.controller.passwordResetRequested(
          email: forgotPasswordEmailTextController.text.trim(),
          context: context,
        );
      }
    },
  );
}

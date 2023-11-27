import 'package:flutter/material.dart';
import '../signin_controller.dart';

class ForgotPasswordDialog extends StatefulWidget {
  final SigninController controller;
  const ForgotPasswordDialog({Key? key, required this.controller})
      : super(key: key);

  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController forgotPasswordEmailTextController =
      new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    forgotPasswordEmailTextController.dispose();
    super.dispose();
  }

  bool forgotPasswordEmailFieldEmpty = true;

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
                  onChanged: (val) => setState(
                      () => forgotPasswordEmailFieldEmpty = val.trim().isEmpty),
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
              SizedBox(height: 20),
              const Text(
                "Check your email for resetting your password",
              ),
            ],
          ),
        ),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );
  }

  Widget get cancelButton => TextButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text("CANCEL"),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget get okButton => TextButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Text("OKAY"),
        ),
        onPressed: () {
          if (!forgotPasswordEmailFieldEmpty ||
              _formKey.currentState!.validate()) {
            widget.controller.passwordResetRequested(
                email: forgotPasswordEmailTextController.text.trim(),
                context: context);
          }
        },
      );
}

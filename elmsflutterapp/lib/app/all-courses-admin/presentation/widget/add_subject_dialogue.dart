// Import statements for the required packages and classes
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Class definition for the AddSubjectDialog, extending StatefulWidget
class AddSubjectDialog extends StatefulWidget {
  // Callback functions for the back button and adding a subject
  final Function() onBack;
  final Function(
      String subjectName, String subjectCode, String subjectDescription) onAdd;

  // Constructor initializing the callbacks
  const AddSubjectDialog({
    Key? key,
    required this.onBack,
    required this.onAdd,
  }) : super(key: key);

  // Override method to create the mutable state for the dialog
  @override
  _AddSubjectDialogState createState() => _AddSubjectDialogState();
}

// Private class for the mutable state of AddSubjectDialog
class _AddSubjectDialogState extends State<AddSubjectDialog> {
  // State variables to store subject details
  String? _subjectName, _subjectCode, _subjectDescription;

  // Override method to build the UI of the dialog
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: getScreenHeight(context),
        width: double.infinity,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            elevation: 6,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              width: getScreenWidth(context) * 0.4,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Back button
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue,
                    ),
                  ),
                  // Course Name input
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text("Course Name",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15,
                            fontFamily: 'Ubuntu')),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (val) => _subjectName = val.trim(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 243, 61, 33),
                              width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Course Name",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Course Code input
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Course Code",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                          fontFamily: 'Ubuntu'),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (val) => _subjectCode = val.trim(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 243, 61, 33),
                              width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Course Code",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Course Description input
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Course Description",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                          fontFamily: 'Ubuntu'),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (val) => _subjectDescription = val.trim(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          borderRadius: BorderRadius.circular
                        BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color.fromARGB(255, 243, 61, 33), width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Course Description",
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Add Course button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (validate(context)) {
                          FocusScope.of(context).unfocus();
                          widget.onAdd(_subjectName!, _subjectCode!, _subjectDescription!);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Add Course",
                          style: TextStyle(
                            fontSize: 17,
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
            ),
          ),
        ),
      ),
    );
  }

  // Validation method to ensure that required fields are filled
  bool validate(BuildContext context) {
    if (_subjectName == null || _subjectName!.isEmpty || _subjectName!.length < 3) {
      Fluttertoast.showToast(msg: "Please enter a valid course name (at least 3 characters)");
      return false;
    }
    
    if (_subjectCode == null || _subjectCode!.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a valid course code");
      return false;
    }

    if (_subjectDescription == null || _subjectDescription!.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a valid course description");
      return false;
    }

    return true;
  }
}

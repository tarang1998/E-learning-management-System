import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddSubjectDialog extends StatefulWidget {
  final Function() onBack;
  final Function(
      String subjectName, String subjectCode, String subjectDescription) onAdd;
  const AddSubjectDialog({Key? key, required this.onBack, required this.onAdd})
      : super(key: key);

  @override
  _AddSubjectDialogState createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  String? _subjectName, _subjectCode, _subjectDescription;
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
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue,
                    ),
                  ),
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
                        hintText: "Course Description",
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (validate(context)) {
                          FocusScope.of(context).unfocus();
                          widget.onAdd(_subjectName!, _subjectCode!,
                              _subjectDescription!);
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "Add Course",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                fontFamily: 'Ubuntu'),
                          )),
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

  bool validate(BuildContext context) {
    if (_subjectName == null) {
      Fluttertoast.showToast(msg: "Please enter a course name");

      return false;
    } else if (_subjectName!.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter a course name");
      return false;
    } else if (_subjectName!.length < 3) {
      Fluttertoast.showToast(
          msg: "Please enter a course name greater than length 3");

      return false;
    }
    if (_subjectCode != null) {
      if (_subjectCode!.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter a course code");

        return false;
      }
    }
    if (_subjectCode == null) {
      Fluttertoast.showToast(msg: "Please enter a course code");

      return false;
    }
    if (_subjectDescription != null) {
      if (_subjectDescription!.isEmpty) {
        Fluttertoast.showToast(msg: "Please enter a course description");

        return false;
      }
    }
    if (_subjectDescription == null) {
      Fluttertoast.showToast(msg: "Please enter a course description");

      return false;
    }
    return true;
  }
}

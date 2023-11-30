// Importing necessary packages and classes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';

// Class definition for HomeFirebaseWrapper
class HomeFirebaseWrapper {
  // Creating an instance of the FirebaseFirestore class
  final firebase = FirebaseFirestore.instance;

  // Asynchronous method to get student data based on student ID
  Future<Map<String, dynamic>> getStudentData({required String studentId}) async {
    // Fetching student data from the Firestore database
    DocumentSnapshot studentData = await firebase.collection('students').doc(studentId).get();

    // Checking if the student data exists
    if (studentData.exists) {
      // Returning the data as a Map
      return studentData.data() as Map<String, dynamic>;
    } else {
      // Throwing an exception if student data does not exist
      throw StudentDataDoesNotExistException();
    }
  }

  // Asynchronous method to get instructor data based on instructor ID
  Future<Map<String, dynamic>> getInstructorData({required String instructorId}) async {
    // Fetching instructor data from the Firestore database
    DocumentSnapshot instructorData = await firebase.collection('instructors').doc(instructorId).get();

    // Checking if the instructor data exists
    if (instructorData.exists) {
      // Returning the data as a Map
      return instructorData.data() as Map<String, dynamic>;
    } else {
      // Throwing an exception if instructor data does not exist
      throw InstructorDataDoesNotExistException();
    }
  }
}

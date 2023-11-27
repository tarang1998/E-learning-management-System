import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';

class HomeFirebaseWrapper {
  final firebase = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getStudentData(
      {required String studentId}) async {
    DocumentSnapshot studentData =
        await firebase.collection('students').doc(studentId).get();

    if (studentData.exists) {
      return studentData.data() as Map<String, dynamic>;
    } else {
      throw StudentDataDoesNotExistException();
    }
  }

  Future<Map<String, dynamic>> getInstructorData(
      {required String instructorId}) async {
    DocumentSnapshot instructorData =
        await firebase.collection('instructors').doc(instructorId).get();

    if (instructorData.exists) {
      return instructorData.data() as Map<String, dynamic>;
    } else {
      throw InstructorDataDoesNotExistException();
    }
  }
}

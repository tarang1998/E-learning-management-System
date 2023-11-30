// Import statements for necessary libraries and dependencies
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:http/http.dart' as http;
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

// Class definition for the CourseRepositoryImpl, implementing the CourseRepository interface
class CourseRepositoryImpl implements CourseRepository {
  // Instance variable for Firebase Firestore
  final firebase = FirebaseFirestore.instance;

  // Implementation of the getAllCourses method to retrieve all courses from Firestore
  @override
  Future<List<CourseEntity>> getAllCourses() async {
    QuerySnapshot query = await firebase.collection('courses').get();

    List<CourseEntity> courses = [];

    query.docs.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code']));
    });

    return courses;
  }

  // Implementation of the getEnrolledCoursesForStudent method to retrieve enrolled courses for a student
  @override
  Future<List<CourseEntity>> getEnrolledCoursesForStudent(
      {required String studentId}) async {
    QuerySnapshot query = await firebase
        .collection('students')
        .doc(studentId)
        .collection('courses')
        .get();

    List<Future<DocumentSnapshot>> getCourseData = [];

    query.docs.forEach((element) {
      getCourseData
          .add(firebase.collection('courses').doc(element['id']).get());
    });

    List<DocumentSnapshot> docs = await Future.wait(getCourseData);
    List<CourseEntity> courses = [];

    docs.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code']));
    });

    return courses;
  }

  // Implementation of the getCoursesYetToBeRegistered method to retrieve unregistered courses for a student
  @override
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId}) async {
    final response = await http.get(Uri.parse(
        'https://us-central1-elms-88a47.cloudfunctions.net/students/v1/getUnregisteredCoursesForStudent?studentId=$studentId'));
    List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    List<CourseEntity> courses = [];
    data.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code'] ?? "X"));
    });

    return courses;
  }

  // Implementation of the getInstructorCourses method to retrieve courses for an instructor
  @override
  Future<List<CourseEntity>> getInstructorCourses(
      {required String instructorId}) async {
    QuerySnapshot query = await firebase
        .collection('instructors')
        .doc(instructorId)
        .collection('courses')
        .get();

    List<Future<DocumentSnapshot>> getCourseData = [];

    query.docs.forEach((element) {
      getCourseData
          .add(firebase.collection('courses').doc(element['id']).get());
    });

    List<DocumentSnapshot> docs = await Future.wait(getCourseData);
    List<CourseEntity> courses = [];

    docs.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code']));
    });

    return courses;
  }

  // Implementation of the addCourse method to add a new course to Firestore
  @override
  Future<void> addCourse({
    required String courseName,
    required String courseCode,
    required String courseDescription,
  }) async {
    // Create a new document reference for the course
    DocumentReference ref = firebase.collection("courses").doc();
    String courseId = ref.id;

    // Add the new course details to Firestore
    await firebase.collection('courses').doc(courseId).set({
      "id": courseId,
      "name": courseName,
      "code": courseCode,
      "description": courseDescription,
    });
  }
}

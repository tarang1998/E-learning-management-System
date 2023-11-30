// Import necessary packages and classes
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:http/http.dart' as http;

// Import the CourseEntity class
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

// Implementation of the CourseRepository interface
class CourseRepositoryImpl implements CourseRepository {
  // Initialize Firestore instance
  final firebase = FirebaseFirestore.instance;

  // Override method to get all courses from Firestore
  @override
  Future<List<CourseEntity>> getAllCourses() async {
    // Query Firestore for all documents in the 'courses' collection
    QuerySnapshot query = await firebase.collection('courses').get();

    // Initialize a list to store CourseEntity objects
    List<CourseEntity> courses = [];

    // Iterate through the documents and create CourseEntity objects
    query.docs.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code']));
    });

    // Return the list of CourseEntity objects
    return courses;
  }

  // Override method to get enrolled courses for a student from Firestore
  @override
  Future<List<CourseEntity>> getEnrolledCoursesForStudent(
      {required String studentId}) async {
    // Query Firestore for documents in the student's 'courses' subcollection
    QuerySnapshot query = await firebase
        .collection('students')
        .doc(studentId)
        .collection('courses')
        .get();

    // Initialize a list to store CourseEntity objects
    List<Future<DocumentSnapshot>> getCourseData = [];

    // Iterate through the documents and create a list of futures to get course data
    query.docs.forEach((element) {
      getCourseData
          .add(firebase.collection('courses').doc(element['id']).get());
    });

    // Wait for all futures to complete
    List<DocumentSnapshot> docs = await Future.wait(getCourseData);
    List<CourseEntity> courses = [];

    // Iterate through the course data and create CourseEntity objects
    docs.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code']));
    });

    // Return the list of CourseEntity objects
    return courses;
  }

  // Override method to get courses yet to be registered for a student from external API
  @override
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId}) async {
    // Make an HTTP request to an external API to get unregistered courses for a student
    final response = await http.get(Uri.parse(
        'https://us-central1-elms-88a47.cloudfunctions.net/students/v1/getUnregisteredCoursesForStudent?studentId=$studentId'));

    // Decode the JSON response
    List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    // Initialize a list to store CourseEntity objects
    List<CourseEntity> courses = [];

    // Iterate through the data and create CourseEntity objects
    data.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code'] ?? "X"));
    });

    // Return the list of CourseEntity objects
    return courses;
  }

  // Override method to get courses taught by an instructor from Firestore
  @override
  Future<List<CourseEntity>> getInstructorCourses(
      {required String instructorId}) async {
    // Query Firestore for documents in the instructor's 'courses' subcollection
    QuerySnapshot query = await firebase
        .collection('instructors')
        .doc(instructorId)
        .collection('courses')
        .get();

    // Initialize a list to store CourseEntity objects
    List<Future<DocumentSnapshot>> getCourseData = [];

    // Iterate through the documents and create a list of futures to get course data
    query.docs.forEach((element) {
      getCourseData
          .add(firebase.collection('courses').doc(element['id']).get());
    });

    // Wait for all futures to complete
    List<DocumentSnapshot> docs = await Future.wait(getCourseData);
    List<CourseEntity> courses = [];

    // Iterate through the course data and create CourseEntity objects
    docs.forEach((element) {
      courses.add(CourseEntity(
          id: element['id'],
          name: element['name'],
          description: element['description'],
          courseCode: element['code']));
    });

    // Return the list of CourseEntity objects
    return courses;
  }

  // Override method to add a new course to Firestore
  @override
  Future<void> addCourse({
    required String courseName,
    required String courseCode,
    required String courseDescription,
  }) async {
    // Generate a new document reference for the course
    DocumentReference ref = firebase.collection("courses").doc();
    String courseId = ref.id;

    // Add the course details to Firestore
    await firebase.collection('courses').doc(courseId).set({
      "id": courseId,
      "name": courseName,
      "code": courseCode,
      "description": courseDescription,
    });
  }
}

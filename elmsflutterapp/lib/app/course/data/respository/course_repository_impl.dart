import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:http/http.dart' as http;

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

class CourseRepositoryImpl implements CourseRepository {
  final firebase = FirebaseFirestore.instance;

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
}

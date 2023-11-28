import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:elmsflutterapp/app/register-courses/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/register-courses/domain/repository/register_course_repository.dart';

class RegisterCourseRepositoryImpl implements RegisterCourseRepository {
  @override
  Future<List<CourseEntity>> getAllCourses() {
    // TODO: implement getAllCourses
    throw UnimplementedError();
  }

  @override
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId}) async {
    final response = await http.get(Uri.parse(
        'https://us-central1-elms-88a47.cloudfunctions.net/students/v1/getUnregisteredCoursesForStudent?studentId=$studentId'));
    List<dynamic> data =
        jsonDecode(response.body) as List<dynamic>;
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
}

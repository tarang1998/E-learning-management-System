import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId});

  Future<List<CourseEntity>> getEnrolledCoursesForStudent(
      {required String studentId});

  Future<List<CourseEntity>> getAllCourses();
}

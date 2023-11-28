import 'package:elmsflutterapp/app/register-courses/domain/entity/courseEntity.dart';

abstract class RegisterCourseRepository {

  Future<List<CourseEntity>> getCoursesYetToBeRegistered({required String studentId});


  Future<List<CourseEntity>> getAllCourses();
}

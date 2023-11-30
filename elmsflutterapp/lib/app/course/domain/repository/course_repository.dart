import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId});

  Future<List<CourseEntity>> getEnrolledCoursesForStudent(
      {required String studentId});

  Future<List<CourseEntity>> getAllCourses();

  Future<List<CourseEntity>> getInstructorCourses({required String instructorId});

  Future<void> addCourse({
    required String courseName,
    required String courseCode,
    required String courseDescription
  });


  Future<CourseEntity> getCourseInfo({required String courseId});


  Future<List<QuestionEntity>> getCourseQuestions({required String courseId});
}



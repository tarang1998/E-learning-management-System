// Import statement for the CourseEntity class, which is the entity representing a course
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

// Abstract class definition for the CourseRepository, outlining methods for interacting with courses
abstract class CourseRepository {
  // Method to fetch courses that a student has yet to register for
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId});

  // Method to fetch courses in which a student is already enrolled
  Future<List<CourseEntity>> getEnrolledCoursesForStudent(
      {required String studentId});

  // Method to fetch all available courses
  Future<List<CourseEntity>> getAllCourses();

  // Method to fetch courses associated with a specific instructor
  Future<List<CourseEntity>> getInstructorCourses({required String instructorId});

  // Method to add a new course to the repository
  Future<void> addCourse({
    required String courseName,
    required String courseCode,
    required String courseDescription
  });
}

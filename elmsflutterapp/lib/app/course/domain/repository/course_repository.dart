// Import statement for the CourseEntity class
import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

// Abstract class definition for CourseRepository, representing the repository interface for course-related operations
abstract class CourseRepository {
  // Method to fetch a list of courses that a student has yet to register for
  Future<List<CourseEntity>> getCoursesYetToBeRegistered({required String studentId});

  // Method to fetch a list of courses that a student is currently enrolled in
  Future<List<CourseEntity>> getEnrolledCoursesForStudent({required String studentId});

  // Method to fetch a list of all available courses
  Future<List<CourseEntity>> getAllCourses();

  // Method to fetch a list of courses associated with a specific instructor
  Future<List<CourseEntity>> getInstructorCourses({required String instructorId});

  // Method to add a new course to the system
  Future<void> addCourse({
    required String courseName,
    required String courseCode,
    required String courseDescription
  });
}

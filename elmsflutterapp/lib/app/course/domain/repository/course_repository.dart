import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:file_picker/file_picker.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getCoursesYetToBeRegistered(
      {required String studentId});

  Future<List<CourseEntity>> getEnrolledCoursesForStudent(
      {required String studentId});

  Future<List<CourseEntity>> getAllCourses();

  Future<List<CourseEntity>> getInstructorCourses(
      {required String instructorId});

  Future<void> addCourse(
      {required String courseName,
      required String courseCode,
      required String courseDescription});

  Future<CourseEntity> getCourseInfo({required String courseId});

  Future<List<QuestionEntity>> getCourseQuestions({required String courseId});

  Future<void> addMCQQuestion(
      {required String courseId,
      required String questionText,
      required num marks,
      required List<PlatformFile> questionImages,
      required Map<int, List<PlatformFile>?>? optionMedia,
      required List<MCQOptionEntity> options,
      required String questionSolutionText,
      required List<PlatformFile> questionSolutionImages});
}

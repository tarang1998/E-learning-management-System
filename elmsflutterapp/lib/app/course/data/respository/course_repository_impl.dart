import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:elmsflutterapp/core/data/firebase_storage.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:http/http.dart' as http;

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

class CourseRepositoryImpl implements CourseRepository {
  final firebase = FirebaseFirestore.instance;

  @override
  Future<CourseEntity> getCourseInfo({required String courseId}) async {
    DocumentSnapshot courseDoc =
        await firebase.collection('courses').doc(courseId).get();

    return CourseEntity(
        id: courseDoc["id"],
        name: courseDoc["name"],
        description: courseDoc["description"],
        courseCode: courseDoc["code"]);
  }

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

  @override
  Future<void> addCourse(
      {required String courseName,
      required String courseCode,
      required String courseDescription}) async {
    DocumentReference ref = firebase.collection("courses").doc();
    String courseId = ref.id;

    await firebase.collection('courses').doc(courseId).set({
      "id": courseId,
      "name": courseName,
      "code": courseCode,
      "description": courseDescription
    });
  }

  @override
  Future<List<QuestionEntity>> getCourseQuestions(
      {required String courseId}) async {
    final QuerySnapshot query = await firebase
        .collection('courses')
        .doc(courseId)
        .collection('questions')
        .get();

    List<QuestionEntity> questions = [];

    query.docs.forEach((element) async {
      Map data = element.data() as Map;

      if (data['type'] == "NUMERICAL") {
        questions.add(MCQQuestionEntity(
          questionId: data["id"],
          courseId: data['courseId'],
          questionText: data["text"],
          marks: data["marks"],
          media: (data['media'] != null)
              ? await extractMediaObject(data['media'])
              : null,
          mcqOptions: await extractMCQOptions(data['options']),
          questionSolutionText: (data['solution']?['text'] != null)
              ? data['solution']['text']
              : null,
          questionSolutionImages: (data['solution']?['media'] != null)
              ? await extractMediaObject(data['solution']['media'])
              : null,
        ));
      } else if (data['type'] == "SUBJECTIVE") {
        questions.add(SubjectiveQuestionEntity(
            questionId: data['id'],
            questionText: data['text'],
            marks: data['marks'],
            media: (data['media'] != null)
                ? await extractMediaObject(data['media'])
                : null,
            questionSolutionText: (data['solution']?['text'] != null)
                ? data['solution']['text']
                : null,
            questionSolutionImages: (data['solution']?['media'] != null)
                ? await extractMediaObject(data['solution']['media'])
                : null,
            courseId: data['courseId']));
      }
    });

    return questions;
  }

  Future<MediaObjectEntity> extractMediaObject(List mediaData) async {
    final FirebaseStorageWrapper _firebaseStorageWrapper =
        serviceLocator<FirebaseStorageWrapper>();

    List<MediaObject> mediaObjects = [];
    List<Future<String>> _futures = [];
    for (var media in mediaData) {
      media = Map<String, dynamic>.from(media);
      _futures.add(_firebaseStorageWrapper.getDownloadableURL(
          _firebaseStorageWrapper.getStoragePath() + media['uri']));
    }

    List<String> mediaUri = await Future.wait(_futures);

    for (int i = 0; i < mediaData.length; i++) {
      Map<String, dynamic> media = Map<String, dynamic>.from(mediaData[i]);
      if (media['type'] == 'IMAGE') {
        mediaObjects.add(ImageMediaObject(imageUri: mediaUri[i]));
      }
    }
    return MediaObjectEntity(mediaObjects: mediaObjects);
  }

  Future<List<MCQOptionEntity>> extractMCQOptions(List mcqOptionsData) async {
    List<Future<MCQOptionEntity>> _futures = [];
    for (var option in mcqOptionsData) {
      _futures.add(mapMCQOptions(Map<String, dynamic>.from(option)));
    }

    List<MCQOptionEntity> mcqOptions = await Future.wait(_futures);
    return mcqOptions;
  }

  Future<MCQOptionEntity> mapMCQOptions(
      Map<String, dynamic> optionsData) async {
    var mcqOptionEntity = MCQOptionEntity(
      isCorrect: optionsData['isCorrect'],
      optionText: optionsData['text'],
      media: optionsData.containsKey('media')
          ? optionsData['media'] != null
              ? await extractMediaObject(optionsData['media'])
              : null
          : null,
    );
    return mcqOptionEntity;
  }
}

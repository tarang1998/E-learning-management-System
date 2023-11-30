import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elmsflutterapp/app/auth/data/user_config.dart';
import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:elmsflutterapp/core/data/firebase_storage.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:http/http.dart' as http;

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';

class CourseRepositoryImpl implements CourseRepository {
  final firebase = FirebaseFirestore.instance;
  final FirebaseStorageWrapper _firebaseStorageWrapper =
      serviceLocator<FirebaseStorageWrapper>();

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

  @override
  Future<void> addMCQQuestion(
      {required String courseId,
      required String questionText,
      required num marks,
      required List<PlatformFile> questionImages,
      required Map<int, List<PlatformFile>?>? optionMedia,
      required List<MCQOptionEntity> options,
      required String questionSolutionText,
      required List<PlatformFile> questionSolutionImages}) async {
    final String _staffId = UserConfig.instance!.uid;
    final DateTime _time = DateTime.now();

    String questionId = firebase
        .collection('courses')
        .doc(courseId)
        .collection('questions')
        .doc()
        .id;

    final String _tempFolderPath =
        '${courseId}/${questionId}/${_time.millisecondsSinceEpoch}';

    List<Map<String, String>> _questionMedia = [];
    List<Map<String, String>> _questionSolutionImages = [];
    Map<int, List<Map<String, String>>> _optionMedia = {};
    Map<String, dynamic> _questionSolutionMedia = {};

    // Upload question media to temp storage bucket
    if (questionImages != null) {
      for (int i = 0; i < questionImages.length; i++) {
        String uri = await _storeQuestionMediaToTempFolderPath(
          media: questionImages[i],
          tempFolderPath: _tempFolderPath,
          mediaIndex: i,
        );

        _questionMedia.add({'type': 'IMAGE', 'uri': uri});
      }
    }

    if (questionSolutionImages != null && questionSolutionImages.isNotEmpty) {
      for (int i = 0; i < questionSolutionImages.length; i++) {
        String uri = await _storeQuestionSolutionMediaToTempFolderPath(
          media: questionSolutionImages[i],
          tempFolderPath: _tempFolderPath,
          mediaIndex: i,
        );

        _questionSolutionImages.add({'type': 'IMAGE', 'uri': uri});
      }

      _questionSolutionMedia['media'] = _questionSolutionImages;
    }
    if (questionSolutionText != null && questionSolutionText.isNotEmpty) {
      _questionSolutionMedia['text'] = questionSolutionText;
    }

    // Upload mcq options media to temp storage bucket
    if (optionMedia != null) {
      List<int> _optionIndices = [];
      for (int i = 0; i < options.length; i++) _optionIndices.add(i);

      for (int mcqIndex in _optionIndices)
        if (optionMedia[mcqIndex] != null) {
          List<Map<String, String>> _tempList = [];
          for (int i = 0; i < optionMedia[mcqIndex]!.length; i++) {
            String uri = await _storeMCQOptionMediaToTempFolderPath(
              media: optionMedia[mcqIndex]![i],
              tempFolderPath: _tempFolderPath,
              mediaIndex: i,
              optionIndex: mcqIndex,
            );

            _tempList.add({'type': 'IMAGE', 'uri': uri});
          }

          _optionMedia[mcqIndex] = _tempList;
        } else {
          _optionMedia[mcqIndex] = [];
        }
    }

    final List<Map<String, dynamic>> mcqOptionsMap = [];
    for (int i = 0; i < options.length; i++) {
      if (options[i].isCorrect != null)
        mcqOptionsMap.add({
          'text': options[i].optionText ?? '',
          'isCorrect': options[i].isCorrect,
          'media': _optionMedia[i],
        });
    }

    await firebase
        .collection('courses')
        .doc(courseId)
        .collection('questions')
        .doc(questionId)
        .set({
      'id': questionId,
      'courseId': courseId,
      'text': questionText,
      'marks': marks,
      'media': _questionMedia,
      'options': mcqOptionsMap,
      'solution': _questionSolutionMedia
    });
  }

  Future<String> _storeQuestionMediaToTempFolderPath({
    required PlatformFile media,
    required String tempFolderPath,
    required int mediaIndex,
  }) async {
    final String path =
        "$tempFolderPath/questionImages/$mediaIndex.${media.extension}";
    final String url = _firebaseStorageWrapper.getStoragePath() + path;
    await _firebaseStorageWrapper.uploadFileToStorageBucket(
        file: media, path: url);

    return path;
  }

  Future<String> _storeQuestionSolutionMediaToTempFolderPath({
    required PlatformFile media,
    required String tempFolderPath,
    required int mediaIndex,
  }) async {
    final String path =
        "$tempFolderPath/questionSolutions/$mediaIndex.${media.extension}";
    final String url = _firebaseStorageWrapper.getStoragePath() + path;
    await _firebaseStorageWrapper.uploadFileToStorageBucket(
        file: media, path: url);

    return path;
  }

  Future<String> _storeMCQOptionMediaToTempFolderPath({
    required PlatformFile media,
    required String tempFolderPath,
    required int mediaIndex,
    required int optionIndex,
  }) async {
    final String path =
        "$tempFolderPath/options/${optionIndex}_$mediaIndex.${media.extension}";
    final String url = _firebaseStorageWrapper.getStoragePath() + path;
    await _firebaseStorageWrapper.uploadFileToStorageBucket(
        file: media, path: url);

    return path;
  }

  Future<void> enrollToCourse(String studentId, String courseId ) async {
    await firebase.collection("students").doc(studentId).collection('courses').doc(courseId).set({
      'id': courseId,
      'enrolledOn' : DateTime.now()
    });
  }

}

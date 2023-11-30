class MediaObjectEntity {
  final List<MediaObject> mediaObjects;
  MediaObjectEntity({required this.mediaObjects});
}

abstract class MediaObject {}

class ImageMediaObject extends MediaObject {
  final String? imageUri;
  ImageMediaObject({required this.imageUri});
}


abstract class QuestionEntity {
  final String questionId;
  final String courseId;
  final String questionText;
  final num marks;
  final MediaObjectEntity? media;
  final String? questionSolutionText;
  final MediaObjectEntity? questionSolutionImages;

  QuestionEntity(
      {
      required this.questionId,
      required this.courseId,
      required this.questionText,
      required this.marks,
      required this.media,
      required this.questionSolutionImages,
      required this.questionSolutionText});
}



class MCQQuestionEntity extends QuestionEntity {
  final List<MCQOptionEntity> mcqOptions;

  MCQQuestionEntity({
    required String questionId,
    required String courseId,
    required String questionText,
    required num marks,
    String? questionSolutionText,
    MediaObjectEntity? questionSolutionImages,
    MediaObjectEntity? media,
    required this.mcqOptions,
    DateTime? updatedAt,
  }) : super(
            questionId: questionId,
            courseId: courseId,
            questionText: questionText,
            marks:marks,
            media: media,
            questionSolutionImages: questionSolutionImages,
            questionSolutionText: questionSolutionText,
            );
}


class MCQOptionEntity {
  final String? optionText;
  final bool isCorrect;
  final MediaObjectEntity? media;

  MCQOptionEntity(
      {required this.optionText, required this.isCorrect, this.media});
}


class SubjectiveQuestionEntity extends QuestionEntity {
  SubjectiveQuestionEntity({
    required String questionId,
    required String courseId,
    required num marks,
    required String questionText,
    MediaObjectEntity? media,
    String? questionSolutionText,
    MediaObjectEntity? questionSolutionImages,
    DateTime? updatedAt,
  }) : super(
            questionId: questionId,
            courseId: courseId,
            questionText: questionText,
            marks: marks,
            media: media,
            questionSolutionText: questionSolutionText,
            questionSolutionImages: questionSolutionImages);
}



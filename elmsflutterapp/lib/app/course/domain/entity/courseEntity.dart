// Class definition for the CourseEntity, representing an entity for a course
class CourseEntity {
  // Properties of the CourseEntity class
  final String id;           // Unique identifier for the course
  final String name;         // Name of the course
  final String description;  // Description of the course
  final String courseCode;   // Code associated with the course

  // Constructor to initialize the CourseEntity with required properties
  CourseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.courseCode,
  });
}

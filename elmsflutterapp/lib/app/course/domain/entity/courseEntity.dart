// Class definition for CourseEntity, representing the entity model for a course
class CourseEntity {
  // Instance variables to store details of a course
  final String id; // Unique identifier for the course
  final String name; // Name of the course
  final String description; // Description of the course
  final String courseCode; // Code associated with the course

  // Constructor for initializing CourseEntity with required parameters
  CourseEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.courseCode,
  });
}

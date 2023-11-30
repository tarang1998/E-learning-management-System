// Class definition for UserEntity
class UserEntity {
  // Fields for user information
  final String id;
  final String email;
  final String name;

  // Constructor for initializing user information
  UserEntity({
    required this.id,
    required this.email,
    required this.name,
  });
}

// Class definition for StudentUserEntity, extending UserEntity
class StudentUserEntity extends UserEntity {
  // Constructor invoking the superclass constructor
  StudentUserEntity({
    required String id,
    required String email,
    required String name,
  }) : super(
          id: id,
          email: email,
          name: name,
        );
}

// Class definition for InstructorUserEntity, extending UserEntity
class InstructorUserEntity extends UserEntity {
  // List to store roles specific to instructors
  final List<String> roles;

  // Constructor invoking the superclass constructor and initializing roles
  InstructorUserEntity({
    required String id,
    required String email,
    required String name,
    required this.roles,
  }) : super(
          id: id,
          email: email,
          name: name,
        );
}

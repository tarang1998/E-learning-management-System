class UserEntity {
  final String id;
  final String email;
  final String name;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
  });
}

class StudentUserEntity extends UserEntity {
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

class InstructorUserEntity extends UserEntity {
  InstructorUserEntity({
    required String id,
    required String email,
    required String name,
  }) : super(
          id: id,
          email: email,
          name: name,
        );
}

import 'package:elmsflutterapp/app/home/data/wrapper/home_firebase_wrapper.dart';
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeFirebaseWrapper firebaseWrapper;
  HomeRepositoryImpl(this.firebaseWrapper);

  InstructorUserEntity? instructorUserEntity;
  StudentUserEntity? studentUserEntity;

  @override
  Future<UserEntity> getUserData(
      {required String userId, required isUserAnInstructor}) async {
    if (isUserAnInstructor) {
      if (instructorUserEntity != null) {
        return instructorUserEntity!;
      }
      Map<String, dynamic> data =
          await firebaseWrapper.getInstructorData(instructorId: userId);

      List<dynamic> rolesData = data["roles"];
      List<String> roles = [];
      rolesData.forEach((role){
        roles.add(role as String);
      });
      return InstructorUserEntity(
          id: data["id"], email: data["email"], name: data["name"],roles: roles);
    } else {
      if (studentUserEntity != null) {
        return studentUserEntity!;
      }

      Map<String, dynamic> data =
          await firebaseWrapper.getStudentData(studentId: userId);
      return StudentUserEntity(
          id: data["id"], email: data["email"], name: data["name"]);
    }
  }
}

// Importing necessary packages and classes
import 'package:elmsflutterapp/app/home/data/wrapper/home_firebase_wrapper.dart';
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';
import 'package:elmsflutterapp/app/home/domain/repository/home_repository.dart';

// Class definition for HomeRepositoryImpl implementing HomeRepository
class HomeRepositoryImpl implements HomeRepository {
  final HomeFirebaseWrapper firebaseWrapper;

  // Constructor for HomeRepositoryImpl
  HomeRepositoryImpl(this.firebaseWrapper);

  // Variables to store user entities
  InstructorUserEntity? instructorUserEntity;
  StudentUserEntity? studentUserEntity;

  // Overriding method to get user data based on user ID and type
  @override
  Future<UserEntity> getUserData(
      {required String userId, required isUserAnInstructor}) async {
    // Checking if the user is an instructor
    if (isUserAnInstructor) {
      // Returning the stored instructor user entity if available
      if (instructorUserEntity != null) {
        return instructorUserEntity!;
      }

      // Fetching instructor data from the Firebase wrapper
      Map<String, dynamic> data =
          await firebaseWrapper.getInstructorData(instructorId: userId);

      // Extracting roles data and converting it to a list of strings
      List<dynamic> rolesData = data["roles"];
      List<String> roles = [];
      rolesData.forEach((role) {
        roles.add(role as String);
      });

      // Creating and returning an instance of InstructorUserEntity
      return InstructorUserEntity(
          id: data["id"], email: data["email"], name: data["name"], roles: roles);
    } else {
      // Returning the stored student user entity if available
      if (studentUserEntity != null) {
        return studentUserEntity!;
      }

      // Fetching student data from the Firebase wrapper
      Map<String, dynamic> data =
          await firebaseWrapper.getStudentData(studentId: userId);

      // Creating and returning an instance of StudentUserEntity
      return StudentUserEntity(
          id: data["id"], email: data["email"], name: data["name"]);
    }
  }
}

// Importing the UserEntity class for return type
import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';

// Abstract class definition for HomeRepository
abstract class HomeRepository {
  // Method to fetch user data based on user ID and role
  Future<UserEntity> getUserData({
    required String userId,
    required bool isUserAnInstructor,
  });
}

import 'package:elmsflutterapp/app/home/domain/entities/userEntity.dart';

abstract class HomeRepository {
  Future<UserEntity> getUserData(
      {required String userId, required isUserAnInstructor});
}

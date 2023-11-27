class UserConfig {
  final String uid;
  final String email;
  final bool isUserAnInstructor;

  static UserConfig? _instance;

  factory UserConfig({required String uid, required String email, required bool isUserAnInstructor }) {
    _instance ??= UserConfig._initalize(uid, email, isUserAnInstructor);
    return _instance!;
  }

  UserConfig._initalize(this.uid, this.email,this.isUserAnInstructor);

  static UserConfig? get instance => _instance;

  static void resetUserData() => _instance = null;
}

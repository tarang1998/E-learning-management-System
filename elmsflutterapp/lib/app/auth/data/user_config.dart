// Class definition for managing user configuration
class UserConfig {
  // Properties for user information
  final String uid;
  final String email;
  final bool isUserAnInstructor;

  // Static instance of UserConfig for singleton pattern
  static UserConfig? _instance;

  // Factory constructor for creating a UserConfig instance
  factory UserConfig({required String uid, required String email, required bool isUserAnInstructor }) {
    // If _instance is null, create a new UserConfig instance, otherwise return the existing instance
    _instance ??= UserConfig._initalize(uid, email, isUserAnInstructor);
    return _instance!;
  }

  // Private constructor for initializing a UserConfig instance
  UserConfig._initalize(this.uid, this.email,this.isUserAnInstructor);

  // Getter for accessing the singleton instance of UserConfig
  static UserConfig? get instance => _instance;

  // Method to reset user data by setting the _instance to null
  static void resetUserData() => _instance = null;
}

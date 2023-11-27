class UserConfig {
    final String uid;
    final String email;
  
    static UserConfig? _instance;
  
    factory UserConfig({required String uid, required String email}) {
      _instance ??= UserConfig._initalize(uid, email);
      return _instance!;
    }
  
    UserConfig._initalize(this.uid, this.email);
  
    static UserConfig? get instance => _instance;
  
    static void resetUserData() => _instance = null;
  }
  
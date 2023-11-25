import '../domain/repository/authentication_repository.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  @override
  Future<bool> checkLoginStatus() async {
    return false;
    // User? firebaseUser = FirebaseAuth.instance.currentUser;
    // if (firebaseUser != null) {
    //   // Resetting user config just to verify if any other config is present previously
    //   UserConfig.resetUserData();
    //   // Initializating user config to cache user details for ease in sentry
    //   UserConfig(
    //     uid: FirebaseAuth.instance.currentUser!.uid,
    //     email: FirebaseAuth.instance.currentUser!.email!,
    //   );

    //   await ApplicationTracker.setupSentryUser();
    //   return true;
    // } else {
    //   return false;
    // }
  }
}

import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC76lH-WJ2XzUQV8OZVtlWcfwONGd1bQVQ",
          projectId: "elms-88a47",
          messagingSenderId: "407067330546",
          appId: "1:407067330546:web:499cbea40637783c168d6b"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillsBerg',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: di.serviceLocator<NavigationService>().navigatorKey,
      initialRoute: NavigationService.splashScreen,
      onGenerateRoute: AppNavigationService.generateRoute,
    );
  }
}

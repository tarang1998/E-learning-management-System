import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
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

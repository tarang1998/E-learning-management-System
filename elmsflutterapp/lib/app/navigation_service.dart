import 'package:elmsflutterapp/app/auth/presentation/sign-in/signin_view.dart';
import 'package:elmsflutterapp/app/home/presentation/home-instructor/home_view.dart';
import 'package:elmsflutterapp/app/home/presentation/home-student/home_view.dart';
import 'package:elmsflutterapp/app/splash_screen/presentation/splash_view.dart';
import 'package:flutter/material.dart';

class AppNavigationService extends NavigationService {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationService.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case NavigationService.signInRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());

      case NavigationService.homepageStudent:
        return MaterialPageRoute(builder: (_) => HomePageStudent());

      case NavigationService.homepageInstructor:
        return MaterialPageRoute(builder: (_) => HomepageInstructor());

      case '/':
        return null;

      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }

  @override
  Future<void> navigateTo(String routeName,
      {bool shouldReplace = false, Object? arguments}) {
    if (shouldReplace) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  void navigateBack() {
    return navigatorKey.currentState!.pop();
  }

  void popUntil(String popUntilRoute) {
    return navigatorKey.currentState!
        .popUntil(ModalRoute.withName(popUntilRoute));
  }

  @override
  Future<void> navigateBackUntil(String untilRoute, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        untilRoute, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => super.navigatorKey;
}

abstract class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String splashScreen = '/splash';
  static const String signInRoute = "/signin";
  static const String homepageStudent = '/home-student';
  static const String homepageInstructor = '/home-instructor';

  Future<void> navigateTo(String routeName,
      {bool shouldReplace = false, Object? arguments});

  void navigateBack();

  Future<void> navigateBackUntil(String untilRoute, {Object? arguments});

  void popUntil(String popUntilRoute);
}

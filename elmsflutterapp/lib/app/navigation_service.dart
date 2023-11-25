import 'package:elmsflutterapp/app/splash_screen/presentation/splash_view.dart';
import 'package:flutter/material.dart';


class AppNavigationService extends NavigationService {
  static Route<dynamic>? generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case NavigationService.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashPage());
        
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
  static const String homepage = '/home';
  
  Future<void> navigateTo(String routeName,
      {bool shouldReplace = false, Object? arguments});

  void navigateBack();

  Future<void> navigateBackUntil(String untilRoute, {Object? arguments});

  void popUntil(String popUntilRoute);
}

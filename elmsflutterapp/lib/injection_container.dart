import 'package:elmsflutterapp/app/auth/data/firebase_authentication_repository_impl.dart';
import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/signin_usecase.dart';
import 'package:elmsflutterapp/app/auth/presentation/sign-in/signin_presenter.dart';
import 'package:elmsflutterapp/app/dashboard/presentation/dashboard_presenter.dart';
import 'package:elmsflutterapp/app/home/data/repository/home_repository_impl.dart';
import 'package:elmsflutterapp/app/home/data/wrapper/home_firebase_wrapper.dart';
import 'package:elmsflutterapp/app/home/domain/repository/home_repository.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:elmsflutterapp/app/home/presentation/home-student/home_presentor.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/check_login_status_usecase.dart';
import 'package:elmsflutterapp/app/register-courses/data/respository/register_course_repository_impl.dart';
import 'package:elmsflutterapp/app/register-courses/domain/repository/register_course_repository.dart';
import 'package:elmsflutterapp/app/register-courses/domain/usecases/get_all_courses.dart';
import 'package:elmsflutterapp/app/register-courses/domain/usecases/get_courses_yet_to_registered.dart';
import 'package:elmsflutterapp/app/register-courses/domain/usecases/get_enrolled_courses_for_student_usecase.dart';
import 'package:elmsflutterapp/app/register-courses/presentation/register-course_presenter.dart';
import 'package:elmsflutterapp/app/splash_screen/presentation/splash_presenter.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator
      .registerLazySingleton<NavigationService>(() => AppNavigationService());

  //==========================================================

  //splash
  serviceLocator.registerFactory(() => SplashPresenter(
        serviceLocator(),
        serviceLocator(),
      ));
  serviceLocator
      .registerFactory(() => CheckLoginStatusUsecase(serviceLocator()));

  //==========================================================

  //signin
  serviceLocator.registerFactory(
      () => SigninPresenter(serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory(() => ForgotPasswordUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => AuthenticateWithEmailAndPasswordUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => SignInUsecase(serviceLocator(), serviceLocator()));
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => FirebaseAuthenticationRepository());

  //==========================================================

  //home
  serviceLocator
      .registerFactory(() => HomePageStudentPresenter(serviceLocator()));
  serviceLocator.registerFactory(() => GetUserDataUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()));
  serviceLocator
      .registerLazySingleton<HomeFirebaseWrapper>(() => HomeFirebaseWrapper());

  //==========================================================

  //register-courses

  serviceLocator
      .registerFactory(() => RegisterCoursePresenter(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllCoursesUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => GetCoursesYetToBeRegistereCoursesdUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => GetEnrolledCoursesForStudentUsecase(serviceLocator()));

  serviceLocator.registerLazySingleton<RegisterCourseRepository>(
      () => RegisterCourseRepositoryImpl());

  //==========================================================

  //dashboard
  serviceLocator.registerFactory(() => DashboardPresenter(serviceLocator()));
}

Future<void> reset() async {
  serviceLocator.resetLazySingleton<HomeRepository>();
  serviceLocator.resetLazySingleton<HomeFirebaseWrapper>();
  serviceLocator.resetLazySingleton<AuthenticationRepository>();
  serviceLocator.resetLazySingleton<RegisterCourseRepository>();
}

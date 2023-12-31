import 'package:elmsflutterapp/app/all-courses-admin/presentation/all_courses_presenter.dart';
import 'package:elmsflutterapp/app/auth/data/firebase_authentication_repository_impl.dart';
import 'package:elmsflutterapp/app/auth/domain/repository/authentication_repository.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/authenticate_with_email_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/register_student_user_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/reset_passsword_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/signin_usecase.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/signout_usecase.dart';
import 'package:elmsflutterapp/app/auth/presentation/registration/presentation/registration_presenter.dart';
import 'package:elmsflutterapp/app/auth/presentation/sign-in/signin_presenter.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/add_course_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/add_mcq_question_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/enroll_to_course_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/getCourseInfoUsecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_course_questions_usecase.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_instructor_courses_usecase.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/mcq_question_presenter.dart';
import 'package:elmsflutterapp/app/course_description/presentation/course_description_presenter.dart';
import 'package:elmsflutterapp/app/course_description/presentation/questionPage/question_bank_presenter.dart';
import 'package:elmsflutterapp/app/dashboard-student/presentation/dashboard_presenter.dart';
import 'package:elmsflutterapp/app/home/data/repository/home_repository_impl.dart';
import 'package:elmsflutterapp/app/home/data/wrapper/home_firebase_wrapper.dart';
import 'package:elmsflutterapp/app/home/domain/repository/home_repository.dart';
import 'package:elmsflutterapp/app/home/domain/usecase/get_user_data_usecase.dart';
import 'package:elmsflutterapp/app/home/presentation/home-instructor/home_presentor.dart';
import 'package:elmsflutterapp/app/home/presentation/home-student/home_presentor.dart';
import 'package:elmsflutterapp/app/instructor-courses/presentation/instructor-courses_presenter.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/app/auth/domain/usecases/check_login_status_usecase.dart';
import 'package:elmsflutterapp/app/course/data/respository/course_repository_impl.dart';
import 'package:elmsflutterapp/app/course/domain/repository/course_repository.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_all_courses.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_courses_yet_to_registered.dart';
import 'package:elmsflutterapp/app/course/domain/usecases/get_enrolled_courses_for_student_usecase.dart';
import 'package:elmsflutterapp/app/profile/presentation/profile_page_presenter.dart';
import 'package:elmsflutterapp/app/register-courses-student/presentation/register-course_presenter.dart';
import 'package:elmsflutterapp/app/splash_screen/presentation/splash_presenter.dart';
import 'package:elmsflutterapp/core/data/firebase_storage.dart';
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

  //auth

  serviceLocator.registerFactory(() => SignoutUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => ResetPasswordUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => RegisterStudentUserUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => SigninPresenter(serviceLocator(), serviceLocator()));
  serviceLocator
      .registerFactory(() => RegistrationPagePresenter(serviceLocator()));
  serviceLocator.registerFactory(() => ForgotPasswordUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => AuthenticateWithEmailAndPasswordUseCase(serviceLocator()));
  serviceLocator
      .registerFactory(() => SignInUsecase(serviceLocator(), serviceLocator()));
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => FirebaseAuthenticationRepository());
  //==========================================================

//profile
  serviceLocator.registerFactory(() => ProfilePagePresenter(
      serviceLocator(), serviceLocator(), serviceLocator()));

  //==========================================================

  //home-student
  serviceLocator
      .registerFactory(() => HomePageStudentPresenter(serviceLocator()));
  //home-instructor
  serviceLocator
      .registerFactory(() => HomePageInstructorPresenter(serviceLocator()));

  //home
  serviceLocator.registerFactory(() => GetUserDataUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()));
  serviceLocator
      .registerLazySingleton<HomeFirebaseWrapper>(() => HomeFirebaseWrapper());

  //==========================================================

  //register-courses
  serviceLocator.registerFactory(
      () => RegisterCoursePresenter(serviceLocator(), serviceLocator()));
  //dashboard-student-registered-courses
  serviceLocator.registerFactory(() => DashboardPresenter(serviceLocator()));

  //instructor-courses
  serviceLocator
      .registerFactory(() => InstructorCoursesPresenter(serviceLocator()));
  //admin-all-courses
  serviceLocator.registerFactory(
      () => AllCoursesPresenter(serviceLocator(), serviceLocator()));
  //course-description
  serviceLocator.registerFactory(
      () => CourseDescriptionMainPagePresenter(serviceLocator()));
  //course-description - question - bank
  serviceLocator.registerFactory(() => QuestionBankPresenter(serviceLocator()));
  //add-question-mcq
  serviceLocator.registerFactory(() => MCQQuestionPresenter(serviceLocator()));

  //courses
  serviceLocator.registerFactory(() => EnrollToCourseUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => AddMCQQuestionUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetCourseQuestionsUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetCourseInfoUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => AddCourseUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetInstructorCoursesUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllCoursesUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => GetCoursesYetToBeRegistereCoursesdUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => GetEnrolledCoursesForStudentUsecase(serviceLocator()));

  serviceLocator
      .registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl());

  //==========================================================

  serviceLocator.registerLazySingleton(() => FirebaseStorageWrapper());
}

Future<void> reset() async {
  serviceLocator.resetLazySingleton<HomeRepository>();
  serviceLocator.resetLazySingleton<HomeFirebaseWrapper>();
  serviceLocator.resetLazySingleton<AuthenticationRepository>();
  serviceLocator.resetLazySingleton<CourseRepository>();
  serviceLocator.resetLazySingleton<FirebaseStorageWrapper>();
}

import 'package:elmsflutterapp/app/course/domain/entity/courseEntity.dart';
import 'package:elmsflutterapp/app/course_description/presentation/course_description_presenter.dart';
import 'package:elmsflutterapp/app/course_description/presentation/course_description_state_machine.dart';
import 'package:elmsflutterapp/app/navigation_service.dart';
import 'package:elmsflutterapp/injection_container.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../core/presentation/observer.dart';

class CourseDescriptionMainPageController extends Controller {
  final CourseDescriptionMainPageStateMachine _stateMachine =
      CourseDescriptionMainPageStateMachine();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();
  final CourseDescriptionMainPagePresenter _presenter;

  CourseDescriptionMainPageController()
      : _presenter = serviceLocator<CourseDescriptionMainPagePresenter>();

  @override
  void initListeners() {}

  CourseDescriptionState? getCurrentState() => _stateMachine.getCurrentState();

  void handleBackPressed() => _navigationService.navigateBack();

  void initialize({
    required String courseId,
  }) {
    _presenter.getCourseInfo(
        UseCaseObserver(() {}, (error) {
          _stateMachine.onEvent(CourseDescriptionErrorEvent());
          refreshUI();
        }, onNextFunc: (CourseEntity course) {
          _stateMachine
              .onEvent(CourseDescriptionInitializedEvent(course: course));
          refreshUI();
        }),
        courseId: courseId);
  }

  void handleCourseDeletion({required String courseId}){
    
  }
}

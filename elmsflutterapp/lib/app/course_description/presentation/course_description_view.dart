import 'package:elmsflutterapp/app/course_description/presentation/course_description_controller.dart';
import 'package:elmsflutterapp/app/course_description/presentation/course_description_state_machine.dart';
import 'package:elmsflutterapp/app/course_description/presentation/widget/inititalized_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as fa;

class CourseDescriptionMainPage extends fa.View {
  final CourseDescriptionMainPageParams params;
  CourseDescriptionMainPage({required this.params});
  @override
  State<StatefulWidget> createState() => CourseDescriptionMainPageView();
}

class CourseDescriptionMainPageView extends fa.ResponsiveViewState<
    CourseDescriptionMainPage, CourseDescriptionMainPageController> {
  CourseDescriptionMainPageView()
      : super(CourseDescriptionMainPageController());

  @override
  Widget get desktopView =>
      fa.ControlledWidgetBuilder<CourseDescriptionMainPageController>(
          builder: (context, controller) {
        final state = controller.getCurrentState();
        final currentState = controller.getCurrentState().runtimeType;
        switch (currentState) {
          case CourseDescriptionInitializationState:
            return buildInitializationStateViewWeb(
              controller,
            );

          case CourseDescriptionInitializedState:
            CourseDescriptionInitializedState initializedState =
                state as CourseDescriptionInitializedState;
            return CourseDescriptionScreenWeb(
              controller: controller,
              initializedState: initializedState,
            );

          case CourseDescriptionLoadingState:
            CourseDescriptionLoadingState loadingState =
                state as CourseDescriptionLoadingState;
            return buildLoadingStateViewWeb();

          case CourseDescriptionErrorState:
            return _buildErrorStateView(
                "Some error has occured. Please try again later ");
        }
        throw Exception("Unrecognized state $currentState encountered");
      });

  @override
  Widget get mobileView => desktopView;

  @override
  Widget get tabletView => desktopView;

  @override
  Widget get watchView => throw UnimplementedError();

  Widget buildLoadingStateViewWeb() {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorStateView(String error) {
    return Scaffold(
        key: globalKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ));
  }

  Widget buildInitializationStateViewWeb(
      CourseDescriptionMainPageController controller) {
    controller.initialize(courseId: widget.params.courseId);
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class CourseDescriptionMainPageParams {
  final String courseId;
  CourseDescriptionMainPageParams({
    required this.courseId,
  });
}

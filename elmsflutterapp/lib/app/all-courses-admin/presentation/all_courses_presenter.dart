import 'package:elmsflutterapp/app/course/domain/usecases/get_all_courses.dart';
import 'package:elmsflutterapp/core/presentation/observer.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AllCoursesPresenter extends Presenter {
  final GetAllCoursesUsecase?
      _getAllCoursesUsecase;

  AllCoursesPresenter(
    this._getAllCoursesUsecase,
  );

  @override
  void dispose() {
    _getAllCoursesUsecase!.dispose();
  }

  void getAllCourses({required UseCaseObserver observer}) {
    _getAllCoursesUsecase!.execute(observer,
        );
  }
}

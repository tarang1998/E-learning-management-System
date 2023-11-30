import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/app/course_description/presentation/add_questions/mcq_question/widgets/mcq_option_widget.dart';
import 'package:flutter/material.dart';

import '../mcq_question_controller.dart';
import '../mcq_question_state_machine.dart';

class MCQOptionsWidgetsList extends StatefulWidget {
  final MCQQuestionController controller;
  final MCQQuestionInitializedState? addInitializedState;

  const MCQOptionsWidgetsList({
    required this.controller,
    this.addInitializedState,
  });

  @override
  _MCQOptionsWidgetsListState createState() => _MCQOptionsWidgetsListState();
}

class _MCQOptionsWidgetsListState extends State<MCQOptionsWidgetsList> {
  Map<int, TextEditingController> textControllers = {};

  @override
  void initState() {
    super.initState();
    int i = 0;
      for (MCQOptionEntity _ in widget.addInitializedState!.options) {
        textControllers[i] = TextEditingController();
        i++;
      }
    
  }

  List<ImageMediaObject> _getCurrentMedia(MediaObjectEntity media) {
    List<ImageMediaObject> _images = [];
    for (MediaObject object in media.mediaObjects) {
      _images.add(object as ImageMediaObject);
    }
    return _images;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        widget.addInitializedState!.options.length,
        (index) => MCQOptionWidget(
          optionImages: widget.addInitializedState!.optionImages[index]!,
          controller: widget.controller,
          index: index,
          textEditingController: textControllers[index]!,
          isSelected: widget.addInitializedState!.options[index].isCorrect ?? false,
        ),
      ),
    );
  }
}

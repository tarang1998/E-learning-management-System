import 'dart:io';

import 'package:elmsflutterapp/core/presentation/widgets/show_image_overlay.dart';
import 'package:elmsflutterapp/utils/sizeConfig.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../mcq_question_controller.dart';

class ExpandedSolutionSection extends StatefulWidget {
  final MCQQuestionController controller;
  final List<PlatformFile> newQuestionSolutionImages;
  final String? questionSolutionText;

  const ExpandedSolutionSection(
      {required this.newQuestionSolutionImages,
      required this.controller,
      this.questionSolutionText});

  @override
  _ExpandedSolutionSectionState createState() =>
      _ExpandedSolutionSectionState();
}

class _ExpandedSolutionSectionState extends State<ExpandedSolutionSection> {
  bool isOpen = false;
  bool imageAdded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getScreenWidth(context) * 0.01),
      child: Material(
        elevation: 3,
        color: Theme.of(context).cardColor,
        shape: Theme.of(context).cardTheme.shape,
        child: Container(
            margin: EdgeInsets.all(getScreenWidth(context) * 0.01),
            child: ExpansionTile(
              title: Text(
                "Question Solution",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              children: [
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[_buildContentBody(context: context)],
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildContentBody({
    required BuildContext context,
  }) {
    void _openFilePicker() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["png", "jpg", "jpeg"],
        allowMultiple: true,
        withData: true,
      );

      if (result != null) {
        widget.controller.addSolutionImagesToNewQuestion(result.files);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            controller: widget.controller.solutionSectionText,
            scrollPadding: const EdgeInsets.symmetric(vertical: 10),
            style: const TextStyle(
              color: Color(0xFF2F3940),
              fontFamily: "UbuntuRegular",
            ),
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Enter Question Solution',
              border: InputBorder.none,
              hintStyle: const TextStyle(
                fontSize: 15.0,
                color: Color(0xFFB9BDBF),
                fontFamily: "UbuntuRegular",
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
          height: 30,
          thickness: 1,
        ),
        if (!imageAdded)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16),
            child: TextButton.icon(
                onPressed: _openFilePicker,
                icon: const Icon(Icons.add_photo_alternate),
                label: Text("Add solution images")),
          ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (PlatformFile image in widget.newQuestionSolutionImages)
                  _buildImageContainer(
                      onRemove: () {
                        widget.newQuestionSolutionImages.remove(image);
                        widget.controller.deleteSolutionImagesFromNewQuestion(
                            widget.newQuestionSolutionImages);
                      },
                      image: Image.memory(image.bytes!)),
                if (imageAdded)
                  IconButton(
                      onPressed: _openFilePicker,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer({
    required Function() onRemove,
    required Image image,
  }) {
    return Container(
      width: 125,
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.black38,
                      builder: (context) {
                        return buildEnlargedImage(
                          context: context,
                          image: image,
                        );
                      });
                },
                child: Container(
                  height: 125,
                  width: 125,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: const Color(0xFFE7E9E9)),
                  ),
                  child: Image(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: onRemove,
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12,
                    child: Center(
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

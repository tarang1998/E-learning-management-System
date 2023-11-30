import 'dart:io';

import 'package:elmsflutterapp/core/presentation/widgets/show_image_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final TextEditingController questionTextController;
  final List<PlatformFile> newQuestionImages;
  final Function(List<PlatformFile>)? addImagesToNewQuestion;
  final Function(List<PlatformFile>)? deleteImagesFromNewQuestion;
  final String questionType;

  const QuestionWidget({
    required this.questionTextController,
    required this.newQuestionImages,
    required this.questionType,
    this.addImagesToNewQuestion,
    this.deleteImagesFromNewQuestion,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  void _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "jpeg"],
      allowMultiple: true,
      withData: true,
    );

    if (result != null) widget.addImagesToNewQuestion!(result.files)!(result.files);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 200,
          decoration:  BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(width: 1, color: const Color(0xFFE7E9E9)),
),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  // onChanged: (_) => widget.refreshPage(),
                  scrollPadding: const EdgeInsets.symmetric(vertical: 10),
                  style: const TextStyle(
                    color: Color(0xFF2F3940),
                    fontFamily: "UbuntuRegular",
                  ),
                  minLines: 5,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  controller: widget.questionTextController,
                  decoration: InputDecoration(
                    hintText: "Enter Question Text",
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFFB9BDBF),
                      fontFamily: "UbuntuRegular",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16),
          child: TextButton.icon(
            onPressed: _openFilePicker,
            icon: const Icon(Icons.add_photo_alternate),
            label: Text("Add question images"),
          ),
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
                
                for (PlatformFile image in widget.newQuestionImages)
                  _buildImageContainer(
                    onRemove: () {
                      widget.newQuestionImages.remove(image);
                     widget.deleteImagesFromNewQuestion!(
                              widget.newQuestionImages);
                    },
                    image: Image.memory(image.bytes!)
                  ),
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
  border: Border.all(width: 1, color: const Color(0xFFE7E9E9)),
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

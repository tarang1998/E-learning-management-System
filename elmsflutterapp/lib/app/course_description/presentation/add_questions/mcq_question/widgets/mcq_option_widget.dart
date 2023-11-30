import 'dart:io';

import 'package:elmsflutterapp/app/course/domain/entity/questionEntity.dart';
import 'package:elmsflutterapp/core/presentation/widgets/show_image_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../mcq_question_controller.dart';

class MCQOptionWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final MCQQuestionController controller;
  final int index;
  final bool isSelected;
  final List<PlatformFile> optionImages;

  const MCQOptionWidget({
    required this.textEditingController,
    required this.controller,
    required this.index,
    required this.isSelected,
    required this.optionImages
  });

  @override
  _MCQOptionWidgetState createState() => _MCQOptionWidgetState();
}

class _MCQOptionWidgetState extends State<MCQOptionWidget> {
  openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpg", "jpeg"],
      allowMultiple: true,
      withData: true,
    );

    if (result != null) {
      widget.controller
          .addOptionImagesToNewQuestion(result.files, widget.index);
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: const Color(0xFFE7E9E9)),
      ),
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (_) => widget.controller.mcqOptionUpdated(
                      optionText: widget.textEditingController.text,
                      index: widget.index,
                    
                      isSelected: widget.isSelected,
                    ),
                  controller: widget.textEditingController,
                  style: const TextStyle(
                    color: Color(0xFF2F3940),
                    fontFamily: "UbuntuRegular",
                  ),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add option" +
                        (widget.index + 1).toString() +
                        (widget.index < 2 ? " *" : ''),
                    hintStyle: const TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFFB9BDBF),
                      fontFamily: "UbuntuRegular",
                    ),
                  ),
                ),
              ),
              Checkbox(
                activeColor: Colors.blue,
                value: widget.isSelected,
                onChanged: (bool? value) => widget.controller.mcqOptionUpdated(
                    optionText: widget.textEditingController.text,
                    index: widget.index,
                    isSelected: value!),
              ),
              TextButton(
                onPressed: openFilePicker,
                child: Text("Add Image"),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Row(
              children: [
                for (PlatformFile file in widget.optionImages)
                  _buildImageContainer(
                      onRemove: () {
                        List<PlatformFile> updateImages = widget.optionImages;
                        updateImages.remove(file);
                        widget.controller.deleteOptionImagesFromNewQuestion(
                            widget.optionImages, widget.index);

                      },
                      image: Image.memory(file.bytes!)),
              ],
            ),
          ),
        ],
      ),
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

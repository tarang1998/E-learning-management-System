import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowImageOverlay extends StatelessWidget {
  final double heightOfImage;
  final String? imagepath;
  final String? printLog;
  final BoxFit? boxFit;

  const ShowImageOverlay(
      {required this.imagepath,
      this.heightOfImage = 180,
      this.printLog,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.black38,
            builder: (context) {
              return buildEnlargedImage(
                context: context,
                image: Image.network(imagepath!)
                
                // CachedNetworkImage(
                //   imageUrl: imagepath!,
                //   width: double.infinity,
                // ),
              );
            });
      },
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          height: heightOfImage,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Image.network(imagepath!
          ),

          
          // CachedNetworkImage(
          //   imageUrl: imagepath!,
          //   fit: boxFit ?? BoxFit.contain,
          //   placeholder: (_, msg) => Container(
          //     height: heightOfImage,
          //     decoration: BoxDecoration(
          //       color: Colors.grey.shade300,
          //       borderRadius: const BorderRadius.all(Radius.circular(6)),
          //     ),
          //     child: const Center(child: Text('Loading Image...')),
          //   ),
          // ),


        ),
      ),
    );
  }
}

Widget buildEnlargedImage({
  required BuildContext context,
  required Widget image,
}) {
  return Stack(
    children: [
      Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: InteractiveViewer(child: image),
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).size.height / 10,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black54),
                  child: const Icon(
                    Icons.close_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                }),
          ),
        ),
      ),
    ],
  );
}

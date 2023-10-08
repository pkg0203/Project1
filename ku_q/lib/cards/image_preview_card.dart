

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePreviewCardFileImage extends StatelessWidget {
  XFile file;
  ImagePreviewCardFileImage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: DottedBorder(
        strokeWidth: 1,
        dashPattern: const [3, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
        child: Container(
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(file.path))
            )
          ),
        )
      ),
    );
  }
}

class ImagePreviewCardNetworkImage extends StatelessWidget {
  String url;
  ImagePreviewCardNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: DottedBorder(
          strokeWidth: 1,
          dashPattern: const [3, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(15),
          child: Container(
            width: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(url)
                )
            ),
          )
      ),
    );
  }
}

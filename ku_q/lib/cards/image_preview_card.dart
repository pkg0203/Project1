

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


class ImagePreviewCard extends StatelessWidget {
  Asset file;
  ImagePreviewCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: DottedBorder(
        strokeWidth: 1,
        dashPattern: const [3, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
        child: AssetThumb(
            asset: file, width: 300, height: 300)
      ),
    );
  }
}

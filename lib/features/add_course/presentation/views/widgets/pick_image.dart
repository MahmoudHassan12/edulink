import 'dart:io' show File;
import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;

class PickImage extends StatefulWidget {
  const PickImage({super.key});
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: AspectRatio(
      aspectRatio: 4 / 3,
      child:
          _imageFile != null
              ? InkWell(
                onTap: _imagePicker,
                child: Image.file(_imageFile!, fit: BoxFit.cover),
              )
              : Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(borderRadius: mBorder),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _imagePicker,
                  child: const Center(
                    child: Icon(Icons.add_photo_alternate_rounded, size: 100),
                  ),
                ),
              ),
    ),
  );

  Future<void> _imagePicker() async {
    _imageFile = await _pickImage();
    setState(() {});
  }
}

Future<File?> _pickImage() =>
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      final path = image?.path;
      return (path?.isNotEmpty ?? false) ? File(path!) : null;
    });

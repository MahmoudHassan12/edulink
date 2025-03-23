import 'dart:io' show File;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;

class PickImage extends StatefulWidget {
  const PickImage({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.imageUrl;
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: GestureDetector(
          onTap: _imagePicker,
          child:
              _imageFile != null
                  ? Image.file(_imageFile!, fit: BoxFit.cover)
                  : (imageUrl?.isNotEmpty ?? false)
                  ? CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover)
                  : const Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: mBorder),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: Icon(Icons.add_photo_alternate_rounded, size: 100),
                    ),
                  ),
        ),
      ),
    );
  }
  Future<void> _imagePicker() async {
    _imageFile = await _pickImage();
    return setState(() {});
  }
}

Future<File?> _pickImage() =>
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      final path = image?.path;
      return (path?.isNotEmpty ?? false) ? File(path!) : null;
    });

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
    final child = ClipRRect(
      borderRadius: circularBorder,
      child:
          _imageFile != null
              ? Image.file(_imageFile!, fit: BoxFit.cover)
              : widget.imageUrl?.isNotEmpty ?? false
              ? CachedNetworkImage(
                imageUrl: widget.imageUrl!,
                fit: BoxFit.cover,
              )
              : const Icon(Icons.add_photo_alternate_rounded, size: 48),
    );

    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: _imagePicker,
        child: CircleAvatar(radius: 48, child: child),
      ),
    );
  }

  Future<void> _imagePicker() => _pickImage().then((image) {
    _imageFile = image;
   return setState(() {});
  });
}

Future<File?> _pickImage() =>
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      final path = image?.path;
      return (path?.isNotEmpty ?? false) ? File(path!) : null;
    });

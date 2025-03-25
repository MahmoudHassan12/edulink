import 'dart:developer';
import 'dart:io' show File;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:supabase_flutter/supabase_flutter.dart';

class PickImage extends StatefulWidget {
  const PickImage({required this.courseId, super.key, this.imageUrl});

  final String? courseId;
  final String? imageUrl;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = _uploadedImageUrl ?? widget.imageUrl;

    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: GestureDetector(
          onTap: _imagePicker,
          child: Stack(
            children: [
              if (_imageFile != null)
                Image.file(_imageFile!, fit: BoxFit.cover)
              else
                (imageUrl?.isNotEmpty ?? false)
                    ? CachedNetworkImage(imageUrl: imageUrl!, fit: BoxFit.cover)
                    : const Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: mBorder),
                      clipBehavior: Clip.antiAlias,
                      child: Center(
                        child: Icon(
                          Icons.add_photo_alternate_rounded,
                          size: 100,
                        ),
                      ),
                    ),
              if (_isUploading)
                const Positioned.fill(
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _imagePicker() async {
    final image = await _pickImage();
    if (image == null) return;

    setState(() => _isUploading = true);

    final imageUrl = await _uploadToSupabase(image);
    if (imageUrl != null) {
      await _saveUrlToFirestore(imageUrl);
      setState(() {
        _imageFile = image;
        _uploadedImageUrl = imageUrl;
        _isUploading = false;
      });
    } else {
      setState(() => _isUploading = false);
    }
  }

  Future<File?> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<String?> _uploadToSupabase(File image) async {
    try {
      final fileName =
          'courses.images/${widget.courseId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Supabase.instance.client.storage
          .from('courses.images')
          .upload(fileName, image);

      return Supabase.instance.client.storage
          .from('courses.images')
          .getPublicUrl(fileName);
    } catch (e) {
      log('Error uploading image: $e');
      _showError('Error while uploading the image, try again later.');
      return null;
    }
  }

  Future<void> _saveUrlToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .update({'imageUrl': imageUrl});
    } catch (e) {
      log('Error saving image URL to Firestore: $e');
      _showError('Error while saving the image, try again later.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }
}

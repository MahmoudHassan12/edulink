import 'dart:developer';
import 'dart:io' show File;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:supabase_flutter/supabase_flutter.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;
  String? _uploadedImageUrl;
  bool _isUploading = false;
  String? userId = getUser()!.id;

  @override
  Widget build(BuildContext context) {
    final child = ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child:
          _imageFile != null
              ? Image.file(_imageFile!, fit: BoxFit.cover)
              : (_uploadedImageUrl ?? widget.imageUrl)?.isNotEmpty ?? false
              ? CachedNetworkImage(
                imageUrl: _uploadedImageUrl ?? widget.imageUrl!,
                fit: BoxFit.cover,
              )
              : const Icon(Icons.add_photo_alternate_rounded, size: 48),
    );

    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: _imagePicker,
        child: CircleAvatar(
          radius: 48,
          child: Stack(
            children: [
              Positioned(child: child),
              if (_isUploading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.purple,
                    ),
                  ),
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
          'user_images/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Supabase.instance.client.storage
          .from('users.images')
          .upload(fileName, image);

      return Supabase.instance.client.storage
          .from('users.images')
          .getPublicUrl(fileName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const EText(
            'Error while uploading the image, try again later.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red[500],
        ),
      );
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _saveUrlToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'imageUrl': imageUrl,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const EText(
            'Error while uploading the image, try again later.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red[500],
        ),
      );
      log('Error saving image URL to Firestore: $e');
    }
  }
}

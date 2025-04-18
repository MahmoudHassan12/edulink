import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/services/content_service.dart';
import 'package:edu_link/features/content/domain/content_item_entity.dart';
import 'package:edu_link/features/content/widgets/conent_app_bar.dart';
import 'package:edu_link/features/content/widgets/content_view_body.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ContentView extends StatefulWidget {
  const ContentView({required this.courseId, super.key});
  final String courseId;
  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final _contentService = ContentService();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const ContentAppbar(),
    body: ContentViewBody(
      courseId: widget.courseId,
      isProfessor: getUser?.isProfessor ?? false,
    ),
    floatingActionButton:
        getUser?.isProfessor ?? false
            ? FloatingActionButton(
              onPressed: handleUploading,
              child: const Icon(Icons.add),
            )
            : null,
  );

  Future<void> handleUploading() async {
    log('FAB Pressed');
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final extension = result.files.single.extension;
      ContentType type;
      if (['mp4'].contains(extension)) {
        type = ContentType.video;
      } else if (['pdf'].contains(extension)) {
        type = ContentType.pdf;
      } else {
        type = ContentType.image;
      }
      await _contentService.uploadContent(file, widget.courseId, type);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upload complete!'),
            backgroundColor: Colors.green,
          ),
        );
      }
      setState(() {});
    }
  }
}

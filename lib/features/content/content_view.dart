import 'dart:io';
import 'dart:developer';
import 'package:edu_link/core/domain/entities/user_entity.dart';
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
  UserEntity? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = getUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContentAppbar(),
      body: ContentViewBody(courseId: widget.courseId),
      floatingActionButton:
          // ignore: use_if_null_to_convert_nulls_to_bools
          _user?.isProfessor == true
              ? FloatingActionButton(
                onPressed: handleUploading,
                child: const Icon(Icons.add),
              )
              : null,
    );
  }

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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Upload complete!'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {});
    }
  }
}

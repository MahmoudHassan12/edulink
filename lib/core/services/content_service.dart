import 'dart:io';

import 'package:edu_link/core/services/supabase_service.dart';
import 'package:edu_link/features/content/domain/content_item_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentService {
  final SupabaseService _supabaseService = const SupabaseService();
  final Supabase _supabase = Supabase.instance;

  Future<String> uploadContent(
    File file,
    String courseId,
    ContentType type,
  ) async {
    final folder = _getFolderName(type);
    return _supabaseService.upload('courses', '$courseId/$folder', file);
  }

  Future<List<ContentItem>> fetchContentsForCourse(String courseId) async {
    final contents = <ContentItem>[];

    for (final type in ContentType.values) {
      final folder = _getFolderName(type);
      final files = await _supabase.client.storage
          .from('courses')
          .list(path: '$courseId/$folder');

      for (final file in files) {
        final fileUrl = _supabaseService.getPublicUrl(
          'courses',
          '$courseId/$folder/${file.name}',
        );
        contents.add(
          ContentItem(
            title: file.name,
            description: 'Uploaded ${_typeName(type)}',
            type: type,
            url: fileUrl,
          ),
        );
      }
    }

    return contents;
  }

  String _getFolderName(ContentType type) {
    switch (type) {
      case ContentType.video:
        return 'videos';
      case ContentType.pdf:
        return 'pdfs';
      case ContentType.image:
        return 'imgs';
    }
  }

  String _typeName(ContentType type) {
    switch (type) {
      case ContentType.video:
        return 'Video';
      case ContentType.pdf:
        return 'PDF';
      case ContentType.image:
        return 'Image';
    }
  }
}

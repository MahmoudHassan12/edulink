import 'dart:io';
import 'package:edu_link/core/domain/entities/video.entity.dart';
import 'package:edu_link/core/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VideoService {
  final SupabaseService _supabaseService = const SupabaseService();
  final Supabase _supabase = Supabase.instance;

  Future<String> uploadVideo(File file, String courseId) async {
    return _supabaseService.upload('courses', '$courseId/videos', file);
  }

  Future<String> uploadThumbnail(File file, String courseId) async {
    return _supabaseService.upload('courses', '$courseId/thumbnails', file);
  }
  
  Future<List<VideoEntity>> fetchVideosForCourse(String courseId) async {
    final videoFiles = await _supabase.client
        .storage
        .from('courses')
        .list(path: '$courseId/videos');

    final videos = <VideoEntity>[];

    for (final file in videoFiles) {
      final videoUrl =
          _supabaseService.getPublicUrl('courses', '$courseId/videos/${file.name}');
      final thumbnailUrl =
          _supabaseService.getPublicUrl('courses', '$courseId/thumbnails/${file.name.split('.').first}.png');

      videos.add(
        VideoEntity(
          fileName: file.name,
          videoUrl: videoUrl,
          thumbnailUrl: thumbnailUrl,
        ),
      );
    }

    return videos;
  }
}

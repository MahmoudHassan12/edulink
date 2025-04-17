import 'dart:developer' show log;
import 'dart:io' show File;

import 'package:edu_link/core/app_keys/supabase_keys.dart'
    show supabaseAnonKey, supabaseUrl;
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart'
    show StorageException, StorageFileApi, Supabase;

// ignore: avoid_classes_with_only_static_members
class SupabaseService {
  const SupabaseService();

  static Future<Supabase> init() =>
      Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  static final Supabase _instance = Supabase.instance;

  StorageFileApi _from(String id) => _instance.client.storage.from(id);

  Future<bool> _fileExists(String id, String path, String fileName) async {
    final list = await _from(id).list(path: path);
    return list.any((file) => file.name == fileName);
  }

  Future<String> upload(String id, String path, File file) async {
    final fileName = p.basename(file.path);
    final filePath = '$path/$fileName';
    final fileExists = await _fileExists(id, path, fileName);
    if (!fileExists) {
      await _from(id)
          .upload(filePath, file)
          .then((e) => fileName)
          .catchError((e) {
            log('Error uploading image: $e');
            throw e;
          })
          .onError<StorageException>((e, _) => throw e);
    }
    return getPublicUrl(id, filePath);
  }

  String getPublicUrl(String id, String path) => _from(id).getPublicUrl(path);
}

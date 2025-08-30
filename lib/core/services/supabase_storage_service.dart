import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final _client = Supabase.instance.client;

  String _makeFileName(String prefix, String ext) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return '$prefix-$ts.$ext';
  }

  Future<String?> uploadFile({
    required String bucket,
    required File file,
    required String userId,
  }) async {
    try {
      final ext = file.path.split('.').last;
      final path = 'profiles/$userId/${_makeFileName("profile", ext)}';

      await _client.storage.from(bucket).upload(path, file);

      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      return null;
    }
  }

  Future<String?> uploadBytes({
    required String bucket,
    required Uint8List bytes,
    required String userId,
    required String fileExtension,
  }) async {
    try {
      final path =
          'profiles/$userId/${_makeFileName("profile", fileExtension)}';

      await _client.storage.from(bucket).uploadBinary(path, bytes);

      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      return null;
    }
  }
}

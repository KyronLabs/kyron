import 'dart:io';
import 'package:dio/dio.dart';
import '../models/profile_summary.dart';
import '../services/api_client.dart';

class ProfileService {
  final Dio _dio = ApiClient().dio;

  Future<String?> uploadAvatar(File file) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final res = await _dio.post(
      '/profile/avatar',
      data: form,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data', // Explicitly set
        },
      ),
    );
    return res.data['url'];
  }

  Future<String?> uploadCover(File file) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final res = await _dio.post(
      '/profile/cover',
      data: form,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
    return res.data['url'];
  }

  Future<void> updateProfile({
    required String name,
    String? bio,
    String? location,
    String? website,
    String? coverUrl,
  }) async {
    await _dio.patch('/profile', data: {
      'name': name,
      'bio': bio,
      if (location != null) 'location': location,
      if (website != null) 'website': website,
      if (coverUrl != null) 'coverUrl': coverUrl,
    });
  }

  Future<void> saveInterests(List<String> interests) async {
    await _dio.post('/profile/interests', data: {
      'interests': interests,
    });
  }

  Future<void> followSuggested(List<String> ids) async {
    if (ids.isEmpty) return;

    await _dio.post('/profile/follow-many', data: {
      'ids': ids,
    });
  }

  /// Returns a URL from the default cover set, or null when storage holds
  /// none. This used to return void and discard the response, so "Randomise"
  /// could not display anything even when the request succeeded.
  Future<String?> randomCover() async {
    final res = await _dio.get('/profile/default-cover/random');
    final data = res.data;
    if (data is Map && data['url'] is String) return data['url'] as String;
    return null;
  }

  /// Accounts worth following, best match first. The first page only: this is
  /// a step in a flow, not a list to scroll for ever.
  Future<List<ProfileSummary>> getSuggestedUsers() async {
    final res = await _dio.get('/profile/suggested');
    final data = res.data;
    final items = data is Map ? data['items'] : null;
    if (items is! List) return const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(ProfileSummary.fromJson)
        .toList();
  }
}

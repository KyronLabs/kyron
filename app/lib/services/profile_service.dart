import 'dart:io';
import 'package:dio/dio.dart';
import '../models/suggested_user.dart';
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
  }) async {
    await _dio.patch('/profile', data: {
      'name': name,
      'bio': bio,
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

  Future<void> randomCover() async {
    await _dio.get('/profile/default-cover/random');
  }

  Future<List<SuggestedUser>> getSuggestedUsers() async {
    final res = await _dio.get('/profile/suggested');
    final data = res.data as List;

    return data.map((e) => SuggestedUser.fromJson(e)).toList();
  }

}
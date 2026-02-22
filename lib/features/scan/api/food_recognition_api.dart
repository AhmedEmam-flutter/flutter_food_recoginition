import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_food_recoginition/core/storge/token_storage.dart';
import 'package:flutter_food_recoginition/features/scan/model/food_recognition_result.dart';

class FoodRecognitionApi {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  FoodRecognitionApi({
    Dio? dio,
    TokenStorage? tokenStorage,
  })  : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'http://foodrecognitionapp.runasp.net',
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 30),
              ),
            ),
        _tokenStorage = tokenStorage ?? TokenStorage();

  Future<FoodRecognitionResult> recognizeFood(File image) async {
    final token = await _tokenStorage.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('TOKEN_MISSING');
    }

    final form = FormData.fromMap({
      'Image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split(Platform.pathSeparator).last,
      ),
    });

    try {
      final res = await _dio.post(
        '/api/foodrecognition/recognize',
        data: form,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final data = res.data;

      if (data is Map<String, dynamic>) {
        return FoodRecognitionResult.fromJson(data);
      } else if (data is Map) {
        return FoodRecognitionResult.fromJson(Map<String, dynamic>.from(data));
      }

      throw Exception('BAD_RESPONSE_FORMAT');
    } on DioException catch (e) {
      final code = e.response?.statusCode;

      if (code == 401) {
        throw Exception('TOKEN_INVALID');
      }

      throw Exception('NETWORK_ERROR: ${e.message ?? 'unknown'}');
    }
  }
}

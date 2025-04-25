// lib/core/utils/api_service.dart
import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service.g.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl = AppConstants.apiBaseUrl;

  ApiService() : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add interceptors for logging, auth tokens, etc.
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw ServerException('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      throw NetworkException('Connection error');
    } else if (e.response != null) {
      if (e.response!.statusCode == 401) {
        // TODO: Handle 401 Unauthorized instead of ServerException
        throw ServerException('Unauthorized: Please login again');
      }
      throw ServerException(
        e.response?.data['message'] ?? 'Server error occurred',
      );
    } else {
      throw ServerException('Something went wrong');
    }
  }
}

@riverpod
ApiService apiService(Ref ref) {
  return ApiService();
}

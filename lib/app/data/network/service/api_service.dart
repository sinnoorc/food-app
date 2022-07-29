import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import 'logging_interceptor.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();

  factory ApiService() => instance;

  ApiService._internal();

  static final _options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );
  final Dio _dio = Dio(_options)..interceptors.add(LoggingInterceptor());

  Future<Response> get(String url) async {
    try {
      final Response response = await _dio.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? data}) async {
    try {
      final Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

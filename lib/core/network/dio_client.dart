import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:work_flow/core/network/check_token_interceptor.dart';

class DioClient {
  final CheckTokenInterceptor checkTokenInterceptor;
  late final Dio _dio;

  DioClient({required this.checkTokenInterceptor})
      : _dio = Dio(
          BaseOptions(
            baseUrl: dotenv.get('API_URL'),
            headers: {
              'X-TOKEN-ACCESS': dotenv.get('API_KEY'),
              'Accept': 'application/json',
            },
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )..interceptors.addAll(
            [checkTokenInterceptor],
          );

  // POST
  Future<Response> post({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final res = await _dio.post(
        url,
        data: data,
      );
      return res;
    } on DioException {
      rethrow;
    }
  }

  // PUT
  Future<Response> put({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final res = await _dio.put(
        url,
        data: data,
      );
      return res;
    } on DioException {
      rethrow;
    }
  }

  // GET
  Future<Response> get({required String url}) async {
    try {
      final res = await _dio.get(url);
      return res;
    } on DioException {
      rethrow;
    }
  }
}

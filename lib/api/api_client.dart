import 'package:dio/dio.dart';

class ApiClient {
  final String baseUrl;
  final Dio _dio;

  ApiClient({required this.baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: 5000,
            receiveTimeout: 5000,
          ),
        );

  Future<Response> getRequest(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}

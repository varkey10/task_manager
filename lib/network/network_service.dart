import 'package:dio/dio.dart';
import 'package:task_manager/network/endpoints.dart';

class ApiService {
  final Dio _dio;
  
  ApiService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 20),
                baseUrl: APiendpoints.endPoint,
              ),
            );

  /// POST request
  Future<Map<String, dynamic>> postData(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  /// GET request
  Future<Map<String, dynamic>> getData(
    String url, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  Future<Map<String, dynamic>> putData(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  Future<Map<String, dynamic>> deleteData(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  Map<String, dynamic> _processResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      // Dio automatically decodes JSON
      return response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : {"data": response.data};
    } else {
      throw Exception(
          'Unexpected status code: ${response.statusCode ?? 'unknown'}');
    }
  }

  Exception _handleDioError(DioError e) {
    if (e.type == DioErrorType.connectionTimeout) {
      return Exception('Connection timeout. Please try again.');
    } else if (e.type == DioErrorType.receiveTimeout) {
      return Exception('Receive timeout. Please try again.');
    } else if (e.response != null) {
      // Server responded but with error status code
      final code = e.response?.statusCode ?? 0;
      final msg = e.response?.data is Map
          ? (e.response?.data['error'] ?? e.response?.data.toString())
          : e.response?.data.toString();
      return Exception('HTTP $code: $msg');
    } else {
      // Something else (network down, canceled, etc.)
      return Exception('Unexpected error: ${e.message}');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:task_manager/network/baseUrl.dart';

class ApiService {
  final Dio _dio = Dio();

  /// POST request
  Future<Map<String, dynamic>> postData({
    required String endPoint,
    Map<String, dynamic>? body,
    required bool isforcred,
  }) async {
    try {
      var urls = isforcred ? APiendpoints.baseUrl2 : APiendpoints.baseUrl;
      final response = await _dio.post(
        urls + endPoint,
        data: body,
        options: Options(headers: {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// GET request
  Future<Map<String, dynamic>> getData(
      {required String endPoint,
      Map<String, dynamic>? query,
      Map<String, String>? headers,
      required bool isforcred}) async {
    try {
      var urls = isforcred ? APiendpoints.baseUrl2 : APiendpoints.baseUrl;

      final response = await _dio.get(
        urls + endPoint,
        queryParameters: query,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT request
  Future<Map<String, dynamic>> putData(
      {required String endPoint,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      required bool isforcred}) async {
    try {
      var urls = isforcred ? APiendpoints.baseUrl2 : APiendpoints.baseUrl;

      final response = await _dio.put(
        urls + endPoint,
        data: body,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE request
  Future<Map<String, dynamic>> deleteData(
      {required String endPoint,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      required bool isforcred}) async {
    try {
      var urls = isforcred ? APiendpoints.baseUrl2 : APiendpoints.baseUrl;

      final response = await _dio.delete(
        urls + endPoint,
        data: body,
        options: Options(headers: headers ?? {"x-api-key": "reqres-free-v1"}),
      );
      return _processResponse(response);
    } on DioException catch (e) {
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
    if (e.type == DioException.connectionTimeout) {
      return Exception('Connection timeout. Please try again.');
    } else if (e.type == DioException.receiveTimeout) {
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

enum Method { get, post, put, delete, form }

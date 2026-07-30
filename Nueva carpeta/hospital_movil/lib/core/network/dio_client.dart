import 'package:dio/dio.dart';
import '../config/env.dart';
import '../error/exceptions.dart';
import '../storage/local_storage.dart';

class DioClient {
  final Dio dio;
  final LocalStorage localStorage;

  DioClient(this.dio, this.localStorage) {
    dio.options = BaseOptions(
      baseUrl: Env.apiBaseUrl,
      connectTimeout: const Duration(milliseconds: Env.connectTimeout),
      receiveTimeout: const Duration(milliseconds: Env.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Dynamic JWT Bearer Token Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await localStorage.read('AUTH_TOKEN');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de espera agotado. Verifica tu conexión.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        if (responseData is Map && responseData.containsKey('message')) {
          return responseData['message'].toString();
        }

        if (statusCode == 403) {
          return 'Acceso denegado (403 Forbidden). Token expirado o no autorizado.';
        } else if (statusCode == 401) {
          return 'No autorizado (401). Credenciales o token inválidos.';
        }

        return 'Error en el servidor ($statusCode)';
      case DioExceptionType.cancel:
        return 'Petición cancelada';
      case DioExceptionType.connectionError:
        return 'No hay conexión con el servidor hospitalario';
      default:
        return 'Ocurrió un error inesperado de red';
    }
  }
}

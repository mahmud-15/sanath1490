import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constant/app_api_url.dart';

class NonAuthApi {
  final Dio _dio = Dio();

  NonAuthApi() {
    _dio.options.baseUrl = AppApiUrl.instance.baseUrl;
    _dio.options.sendTimeout = const Duration(seconds: 60);
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.followRedirects = false;
    _dio.interceptors.addAll({
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = AppApiUrl.instance.baseUrl;
          options.contentType = 'application/json';
          options.headers["Accept"] = "application/json";
          return handler.next(options);
        },
        onError: (error, handler) async {
          return handler.next(error);
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          request: true,
          compact: true,
          error: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
    });
  }

  Dio get sendRequest => _dio;
}

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../Widget/app_snack_bar/app_snack_bar.dart';
import '../../utils/log_print.dart';
import '../storage/storage_services.dart';
import 'api.dart';

class ApiServices {
  ApiServices._privateConstructor();
  static final ApiServices _instance = ApiServices._privateConstructor();
  static ApiServices get instance => _instance;

  final api = AppApi.instance;  // ✅ Use singleton instance
  var storageServices = StorageServices.instance;

  // ✅ Common error handler
  Future<dynamic> _handleRequest(
      Future<Response> Function() request, {
        int? statusCode,
        int? statusCodeStart,
        int? statusCodeEnd,
      }) async {
    try {
      final response = await request();

      // Check status code
      bool isSuccess = false;
      if (statusCode != null) {
        isSuccess = response.statusCode == statusCode;
      } else if (statusCodeStart != null && statusCodeEnd != null) {
        isSuccess = response.statusCode! >= statusCodeStart &&
            response.statusCode! <= statusCodeEnd;
      }

      if (isSuccess) {
        return response.data;
      } else {
        AppSnackBar.error("Unexpected response: ${response.statusCode}");
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      AppSnackBar.error("Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api timeout exception', e);
      AppSnackBar.error("Request timed out");
      return null;
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e) {
      errorLog('api exception', e);
      AppSnackBar.error("Something went wrong");
      return null;
    }
  }

  // ✅ Handle Dio exceptions
  Future<dynamic> _handleDioException(DioException e) async {
    if (e.response != null) {
      // Note: 401 is already handled in AppApi interceptor
      // So we don't need to handle it again here

      final message = e.response?.data?["message"];
      if (message != null) {
        AppSnackBar.error("$message");
      } else {
        AppSnackBar.error("Error: ${e.response?.statusCode}");
      }
    } else {
      AppSnackBar.error("Network error");
    }

    errorLog('api dio exception', e);
    return null;
  }

  // ✅ GET Request
  Future<dynamic> getServices(
      String url, {
        int statusCode = 200,
        Map<String, dynamic>? queryParameters,
        dynamic body,
      }) async {
    return _handleRequest(
          () => api.sendRequest.get(url, queryParameters: queryParameters, data: body),
      statusCode: statusCode,
    );
  }
  // ✅ POST Request
  Future<dynamic> postServices({
    required String url,
    dynamic body,
    int statusCodeStart = 200,
    int statusCodeEnd = 299,
    Map<String, dynamic>? query,
  }) async {
    return _handleRequest(
          () => api.sendRequest.post(url, data: body, queryParameters: query),
      statusCodeStart: statusCodeStart,
      statusCodeEnd: statusCodeEnd,
    );
  }

  // ✅ PUT Request
  Future<dynamic> putServices({
    required String url,
    dynamic body,
    int statusCode = 200,
    Map<String, dynamic>? query,
  }) async {
    return _handleRequest(
          () => api.sendRequest.put(url, data: body, queryParameters: query),
      statusCode: statusCode,
    );
  }

  // ✅ PATCH Request
  Future<dynamic> patchServices({
    required String url,
    Object? body,
    int statusCode = 200,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _handleRequest(
          () => api.sendRequest.patch(url, data: body, queryParameters: query, options: options),
      statusCode: statusCode,
    );
  }

  // ✅ DELETE Request
  Future<dynamic> deleteServices({
    required String url,
    Object? body,
    int statusCode = 200,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return _handleRequest(
          () => api.sendRequest.delete(url, data: body, queryParameters: query, options: options),
      statusCode: statusCode,
    );
  }
}
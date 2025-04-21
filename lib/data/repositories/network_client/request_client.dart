import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:travelactivity/data/repositories/network_client/extensions.dart';
import 'package:travelactivity/shared/constants/env_configs.dart';

import 'exceptions.dart';

enum RequestType { post, get, delete, put, patch }

class RequestClient {
  static final Logger _logger = Logger('RequestClient');

  final Dio dio = getDio();

  static Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = EnvironmentConfigs.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.headers['Accept-Encoding'] = 'gzip';

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          _logger.finest(
            "\n🦠 Error in response\nCode: ${e.response?.statusCode}\nData: ${e.response?.data}",
          );
          throw e.handleApiError();
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: false,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: false,
          error: true,
          logPrint: (Object object) {
            _logger.info(object);
          },
        ),
      );
    }
    return dio;
  }

  Map<String, String> getHeaders() {
    String? token = '';

    var data = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    data["Authorization"] = "Bearer $token";

    return data;
  }

  Future<Response> post({required String endpoint, body}) async {
    try {
      final response = await dio.post(
        EnvironmentConfigs.baseUrl + endpoint,
        data: body,
        options: Options(
          headers: getHeaders(),
          contentType: 'application/json',
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        throw UnauthorizedException();
      }
      rethrow;
    }
  }

  Future<Response> get({String? url, String? endpoint}) async {
    try {
      final response =
          url != null
              ? await dio.get(url)
              : await dio.get(
                EnvironmentConfigs.baseUrl + endpoint!,
                options: Options(
                  headers: getHeaders(),
                  contentType: 'application/json',
                ),
              );

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        throw UnauthorizedException();
      }
      rethrow;
    }
  }

  Future<Response> delete({required String endpoint, body}) async {
    try {
      final response = await dio.delete(
        EnvironmentConfigs.baseUrl + endpoint,
        data: body,
        options: Options(
          headers: getHeaders(),
          contentType: 'application/json',
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        throw UnauthorizedException();
      }
      rethrow;
    }
  }

  Future<Response> put({required String endpoint, body}) async {
    try {
      final response = await dio.put(
        EnvironmentConfigs.baseUrl + endpoint,
        data: body,
        options: Options(
          headers: getHeaders(),
          contentType: 'application/json',
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        throw UnauthorizedException();
      }
      rethrow;
    }
  }

  Future<Response> patch({required String endpoint, body}) async {
    try {
      final response = await dio.patch(
        EnvironmentConfigs.baseUrl + endpoint,
        data: body,
        options: Options(
          headers: getHeaders(),
          contentType: 'application/json',
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        throw UnauthorizedException();
      }
      rethrow;
    }
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  noInternetConnection,
  defaultStatus,
}

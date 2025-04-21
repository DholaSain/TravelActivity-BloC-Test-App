import 'package:dio/dio.dart';

enum ApiError {
  invalidCredentials,
  badRequest,
  invalidToken,
  phoneAlreadyExist,
  phoneNotVerified,
  emailAlreadyExist,
  invalidOtp,
  invalidPassword,
  expiredToken,
  notFound,
  duplicateData,
  notAllowed,
  roleMismatch,
  userNotFound,
  serverError,
  unknown,
}

extension ApiErrorStringExtension on String {
  ApiError getApiError() {
    switch (this) {
      case 'invalidCredentials':
        return ApiError.invalidCredentials;
      case 'invalidToken':
        return ApiError.invalidToken;
      case 'phoneAlreadyExist':
        return ApiError.phoneAlreadyExist;
      case 'phoneNotVerified':
        return ApiError.phoneNotVerified;
      case 'emailAlreadyExist':
        return ApiError.emailAlreadyExist;
      case 'invalidOtp':
        return ApiError.invalidOtp;
      case 'invalidPassword':
        return ApiError.invalidPassword;
      case 'expiredToken':
        return ApiError.expiredToken;
      case 'notFound':
        return ApiError.notFound;
      case 'duplicateData':
        return ApiError.duplicateData;
      case 'notAllowed':
        return ApiError.notAllowed;
      case 'roleMismatch':
        return ApiError.roleMismatch;
      case 'userNotFound':
        return ApiError.userNotFound;
      case 'serverError':
      case 'Internal server error':
        return ApiError.serverError;
      case 'invalidData':
      case 'invalidRequest':
      case "Bad Request":
        return ApiError.badRequest;
      default:
        return ApiError.unknown;
    }
  }
}

extension ApiErrorIntExtension on int? {
  ApiError getApiError() {
    switch (this) {
      case 400:
        return ApiError.badRequest;
      case 401:
        return ApiError.invalidToken;
      case 403:
        return ApiError.notAllowed;
      case 404:
        return ApiError.notFound;
      case 409:
        return ApiError.duplicateData;
      case 500:
        return ApiError.serverError;
      default:
        return ApiError.unknown;
    }
  }
}

extension ApiErrorExtension on ApiError {
  String getErrorMessage() {
    switch (this) {
      case ApiError.invalidCredentials:
        return "";
      case ApiError.invalidToken:
        return "";
      case ApiError.phoneAlreadyExist:
        return "";
      case ApiError.emailAlreadyExist:
        return "";
      case ApiError.invalidOtp:
        return "";
      case ApiError.invalidPassword:
        return "";
      case ApiError.expiredToken:
        return "";
      case ApiError.notFound:
        return "";
      case ApiError.duplicateData:
        return "";
      case ApiError.notAllowed:
        return "";
      case ApiError.roleMismatch:
        return "";
      case ApiError.serverError:
        return "";
      case ApiError.badRequest:
        return "";
      case ApiError.unknown:
        return "";
      case ApiError.phoneNotVerified:
        return "";
      case ApiError.userNotFound:
        return "";
    }
  }
}

extension DioExceptionApiError on DioException {
  ApiError handleApiError() {
    if (response != null) {
      if (response!.data is String) {
        return response!.statusCode.getApiError();
      } else if (response!.data['message'] is String) {
        return response!.data['message'].toString().getApiError();
      } else if (response!.data['error'] != null) {
        return response!.data['error'].toString().getApiError();
      } else {
        return ApiError.serverError;
      }
    } else {
      return ApiError.serverError;
    }
  }
}

import 'dart:async';
import 'dart:io';
import 'error_model.dart';

sealed class Failure implements Exception {
  final ErrorModel model;
  const Failure(this.model);
}
class CachingException extends Failure {
  CachingException(super.model);
}


class ApiException extends Failure {
  ApiException(super.model);
}

class NetworkException extends Failure {
  NetworkException(super.model);
}

class UnauthorizedException extends Failure {
  UnauthorizedException(super.model);
}

class ForbiddenException extends Failure {
  ForbiddenException(super.model);
}

class NotFoundException extends Failure {
  NotFoundException(super.model);
}

class ConflictException extends Failure {
  ConflictException(super.model);
}

class TooManyRequestsException extends Failure {
  TooManyRequestsException(super.model);
}

class ServiceUnavailableException extends Failure {
  ServiceUnavailableException(super.model);
}

class RequestTimeoutException extends Failure {
  RequestTimeoutException(super.model);
}

class BadRequestException extends Failure {
  BadRequestException(super.model);
}

class ServerException extends Failure {
  ServerException(super.model);
}

class DecodingException extends Failure {
  DecodingException(super.model);
}

Exception throwError(
  Exception type,
  ErrorModel model,
) {
  if (type is SocketException) return NetworkException(model);
  if (type is TimeoutException) return RequestTimeoutException(model);
  if (type is FormatException) return BadRequestException(model);
  if (type is HttpException) return ServerException(model);

  switch (model.statusCode) {
    case 400:
      return BadRequestException(model);
    case 401:
      return UnauthorizedException(model);
    case 403:
      return ForbiddenException(model);
    case 404:
      return NotFoundException(model);
    case 409:
      return ConflictException(model);
    case 429:
      return TooManyRequestsException(model);
    case 500:
    case 502:
      return ServerException(model);
    case 503:
      return ServiceUnavailableException(model);
    case 504:
      return RequestTimeoutException(model);
    default:
      return ApiException(model);
  }
}

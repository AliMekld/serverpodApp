import '../request_Methods.dart';

class ErrorModel {
  final String statusMessage;
  final String? message;
  final int statusCode;

  ErrorModel.init({
    this.message,
    required RequestMethod method,
    required this.statusCode,
  }) : statusMessage = message ?? StatusCode.fromCode(statusCode).message;

  ErrorModel({
    required this.statusCode,
    this.message,
  }) : statusMessage = message ?? StatusCode.fromCode(statusCode).message;

  @override
  String toString() {
    return 'ErrorModel(message: $statusMessage, statusCode: $statusCode)';
  }
}

enum StatusCode {
  _unKnown(-1, 'unKnown ERROR'),
  // 2xx Success
  ok(200, 'OK'),
  created(201, 'Created'),
  accepted(202, 'Accepted'),
  noContent(204, 'No Content'),

  // 3xx Redirection
  movedPermanently(301, 'Moved Permanently'),
  found(302, 'Found'),
  notModified(304, 'Not Modified'),

  // 4xx Client Errors
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  methodNotAllowed(405, 'Method Not Allowed'),
  notAcceptable(406, 'Not Acceptable'),
  proxyAuthRequired(407, 'Proxy Authentication Required'),
  requestTimeout(408, 'Request Timeout'),
  conflict(409, 'Conflict'),
  gone(410, 'Gone'),
  lengthRequired(411, 'Length Required'),
  preconditionFailed(412, 'Precondition Failed'),
  payloadTooLarge(413, 'Payload Too Large'),
  uriTooLong(414, 'URI Too Long'),
  unsupportedMediaType(415, 'Unsupported Media Type'),
  tooManyRequests(429, 'Too Many Requests'),

  // 5xx Server Errors
  internalServerError(500, 'Internal Server Error'),
  notImplemented(501, 'Not Implemented'),
  badGateway(502, 'Bad Gateway'),
  serviceUnavailable(503, 'Service Unavailable'),
  gatewayTimeout(504, 'Gateway Timeout'),
  httpVersionNotSupported(505, 'HTTP Version Not Supported'),
  variantAlsoNegotiates(506, 'Variant Also Negotiates'),
  insufficientStorage(507, 'Insufficient Storage'),
  loopDetected(508, 'Loop Detected'),
  notExtended(510, 'Not Extended'),
  networkAuthenticationRequired(511, 'Network Authentication Required');

  factory StatusCode.fromCode(int code) => values
      .firstWhere((e) => e.code == code, orElse: () => StatusCode._unKnown);
  final int code;
  final String message;
  const StatusCode(this.code, this.message);
}

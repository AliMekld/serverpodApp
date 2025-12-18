// ignore_for_file: unused_local_variable

import 'Errors/error_model.dart';
import 'Errors/exceptions.dart';

import 'request_Methods.dart';

class GenericRequest<T> {
  final T Function(Map<String, dynamic>) fromMap;
  final RequestMethod method;
  const GenericRequest({
    required this.fromMap,
    required this.method,
  });
  Future<T> getObject() async {
    final BaseResponseModel response = method.body == null
        ? await method.requestJson()
        : await method.request();

    /// todo handle formating and serialization errors
    T object = fromMap(response.body);
    return object;
  }

  Future<List<T>> getList() async {
    List<T> tList = [];
    BaseResponseModel response = method.body == null
        ? await method.requestJson()
        : await method.request();
    if (response.body is List) {
      final responseBody = response.body;
      List dList = [];
      tList = List<T>.from(dList.map((e) => fromMap(e)));

      /// todo handle formating and serialization errors
      return tList;
    } else {
      throw DecodingException(ErrorModel(
          statusCode: 520,
          message:
              'data is not compitable with the expected data ${T.runtimeType}'));
    }
  }

  Future<dynamic> getResponse() async {
    final BaseResponseModel response = method.body == null
        ? await method.requestJson()
        : await method.request();

    return response.body;
  }
}

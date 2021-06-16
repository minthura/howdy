import 'package:dio/dio.dart';
import 'package:minhttp/services/http_error.dart';

class BaseService {
  void handleError(dynamic e, Function(HttpError) callback) {
    if (e is HttpError) {
      callback(e);
    } else {
      print(e);
      callback(HttpError(DioError(type: DioErrorType.DEFAULT)));
    }
  }
}

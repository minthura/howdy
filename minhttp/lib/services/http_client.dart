import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:minhttp/models/city.dart';
import 'package:minhttp/services/base_service.dart';
import 'package:minhttp/services/http_error.dart';

class HttpClient {
  static String _authToken;
  static Dio _dio;
  BaseService _baseService;
  HttpClient() {
    this._baseService = BaseService();
  }
  static void initialize(String baseUrl) {
    _dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 5000
      ..options.receiveTimeout = 3000
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        // Do something before request is sent
        print('url: ' + options.uri.toString());
        if (_authToken != null && _authToken.isNotEmpty) {
          options.headers.putIfAbsent('Authorization', () => _authToken);
        }
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      }, onResponse: (Response response) async {
        // Do something with response data
        return response; // continue
      }, onError: (DioError e) async {
        // Do something with response error
        // print(e.message);
        // print(e.response.data);
        print('ERROR: ${e.message}');
        print('RESPONSE: ${e.response}');
        return HttpError(e); //continue
      }));
  }

  static HttpClient instance = HttpClient();

  void setAuthToken(String token) {
    _authToken = token;
  }

  Future<dynamic> get(
      String url, Function success, Function(HttpError) error) async {
    return await _dio
        .get(url)
        .then((value) => success(value))
        .catchError((e) => _baseService.handleError(e, error));
  }

  Future<dynamic> post(String url, Map<String, dynamic> data) async {
    final Response response = await _dio.post(url, data: data);
    return response.data;
  }

  // Future<void> oneCall(
  //     Function(OneCall) success, Function(HttpError) error) async {
  //   const String url =
  //       '/onecall?lat=16.8409&lon=96.1735&exclude=hourly,minutely&appid=d5cb0deed48210c37613979a3d3bb432';
  //   await _dio.get(url).then(
  //     (value) {
  //       final obj = OneCall.fromJson(value.data);
  //       success(obj);
  //     },
  //   ).catchError((e) => _baseService.handleError(e, error));
  // }
  Future<List<City>> getCities(filter) async {
    var response = await _dio.get(
      "https://60c9c2cb772a760017204576.mockapi.io/cities",
      queryParameters: filter.toString().isEmpty ? null : {"name": filter},
    );
    var models = cityFromJson(json.encode(response.data));
    return models;
  }

  Future<void> getData(
      String url, Function success, Function(HttpError) error) async {
    await _dio.get(url).then(
      (value) {
        // throw Exception('This is error from me!');
        success(value);
      },
    ).catchError((e) => _baseService.handleError(e, error));
  }
}

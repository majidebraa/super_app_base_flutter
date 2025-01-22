import 'dart:async';
import 'package:dio/dio.dart';
import '../local/local_data_source.dart';
import 'app_exception.dart';
import 'const_helper.dart';
import 'remote_module.dart';


class RemoteModuleImpl extends RemoteModule {
  final LocalDataSource localDataSource;
  final Dio dio;

  RemoteModuleImpl(this.localDataSource, this.dio) {
    /*dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectionTimeOut,
        receiveTimeout: connectionTimeOut,
      ),
    );*/

    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add headers
        options.headers.addAll(await _prepareHeaders());
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle successful responses
        return handler.next(response);
      },
      onError: (error, handler) {
        // Handle errors globally
        _handleError(error);
        return handler.next(error);
      },
    ));
  }

  Future<Map<String, String>> _prepareHeaders() async {
    Map<String, String> headers = {"Accept": "application/json"};
    final token = await localDataSource.getPref(LocalDataSource.accessTokenKey);
    if (token!.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  @override
  Future<dynamic> getResponse(
      String pathUrl,
      RequestType requestType, {
        Map<String, dynamic> body = const {},
        Map<String, dynamic> headers = const {},
        bool isQueryParams = false,
      }) async {
    try {
      Response response;
      final options = Options(headers: headers);

      switch (requestType) {
        case RequestType.get:
          response = await dio.get(
            pathUrl,
            queryParameters: isQueryParams ? body : null,
            options: options,
          );
          break;
        case RequestType.post:
          response = await dio.post(
            pathUrl,
            data: isQueryParams ? null : body,
            options: options,
          );
          break;
        case RequestType.put:
          response = await dio.put(
            pathUrl,
            data: body,
            options: options,
          );
          break;
        case RequestType.delete:
          response = await dio.delete(
            pathUrl,
            data: body,
            options: options,
          );
          break;
      }

      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred with status code: ${response.statusCode}',
        );
    }
  }

  AppException _handleError(DioException error) {
    switch(error.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return FetchDataException('Connection timeout');
      case DioExceptionType.connectionError :
        return FetchDataException('No internet connection');
      case DioExceptionType.unknown:
        return FetchDataException('Unknown error occurred');
      default:
        return FetchDataException('Unexpected error occurred');
    }

  }
}
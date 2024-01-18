

import 'package:dio/dio.dart';

import '../local/storagehelper.dart';
import 'CustomInterceptor.dart';

class NetworkService extends Interceptor with StorageHelper {
  String token = "";
  Map<String, String> mp = {};
  static NetworkService? _instace;
  static NetworkService get instance {
    if (_instace != null) return _instace!;
    _instace = NetworkService._init();
    return _instace!;
  }


  final String _baseUrl1 = "https://xworld-api-00eee6c028f9.herokuapp.com";
  late final Dio dio;

  NetworkService._init() {
    dio = Dio(BaseOptions(baseUrl: _baseUrl1));
          dio.interceptors.add(CustomInterceptor());
          // dio.interceptors.add(LogInterceptor(
          //   request: true,
          //   requestHeader: true,
          //   requestBody: true,
          //   error: true,
          //   responseHeader: true,
          //   responseBody: true,
          // ));

  }
}

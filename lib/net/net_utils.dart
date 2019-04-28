import 'dart:io' show ContentType, Cookie, HttpHeaders;
import 'package:PMES/utils/log.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class NetUtils{

  factory NetUtils() => _getInstance();
  static NetUtils _instance;
  static NetUtils get instance => _getInstance();

  static Dio dio;

  NetUtils._internal(){
    BaseOptions options = BaseOptions()
      ..receiveTimeout = 5000
      ..connectTimeout = 5000;
    dio = new Dio(options);
    dio.interceptors.add(CookieManager(CookieJar()));
  }

  static NetUtils _getInstance(){
    if(_instance == null){
      _instance = NetUtils._internal();
    }
    return _instance;
  }

  Future<String> get(String url,Map<String,dynamic> params)async{
    Response response = await dio.get(
        url,
        queryParameters: params,
        options: Options(
            contentType: ContentType.parse("application/x-www-form-urlencode")
        )
    );
    Log.e(response.toString());
    return response.toString();
  }

  Future<String> post(String url,{Map<String,dynamic> params,dynamic data})async{
    Response response = await dio.post(
      url,
      data: data,
      queryParameters: params,
      options: Options(
          contentType: data != null?ContentType.parse("application/json"):ContentType.parse("application/x-www-form-urlencode")
      )
    );
    return response.toString();
  }

}
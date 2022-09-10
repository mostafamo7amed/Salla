import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static init(){
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          contentType: 'application/json'
      ),

    );
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port,) => true;
      return client;
    };
  }

  static Future<Response> getData({
    required String url,
    Map<String , dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    dio!.options.headers ={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );

  }

  static Future<Response> postData({
    required String url,
    required Map<String , dynamic> data,
    String lang = 'en',
    String token = '',
  }) async{
    dio!.options.headers ={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return await dio!.post(
      url,
      data: data,
    );
  }
}




//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fcb8108a1c6440408a96c64ca098744c
//fcb8108a1c6440408a96c64ca098744c
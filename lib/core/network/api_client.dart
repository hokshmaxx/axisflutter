import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://192.168.1.3/api/'));

  Future<Response> getRequest(String endpoint) async => await dio.get(endpoint);
  Future<Response> postRequest(String endpoint, Map<String, dynamic> data) async => await dio.post(endpoint, data: data);
  Future<Response> putRequest(String endpoint, Map<String, dynamic> data) async => await dio.put(endpoint, data: data);
  Future<Response> deleteRequest(String endpoint) async => await dio.delete(endpoint);
}

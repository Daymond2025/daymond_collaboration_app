import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:dio/dio.dart';

class DioRepository {
  static DioRepository? _instance;
  static DioRepository get instance => _instance ??= DioRepository._init();

  DioRepository._init();

  late Dio _dio;

  Dio apiRepository(String? token) {
    BaseOptions options = BaseOptions(
        baseUrl: apiUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        responseType: ResponseType.json,
        contentType: 'application/json',
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! < 500;
        },
        connectTimeout: const Duration(seconds: 60), // 60 seconds
        receiveTimeout: const Duration(seconds: 60) // 60 seconds
        );
    _dio = Dio(options);
    return _dio;
  }

  Dio get dio => _dio;
}

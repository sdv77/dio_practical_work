import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get_it/get_it.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = dotenv.env['API_NINJAS_KEY'];
    super.onRequest(options, handler);
  }
}

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<String> getFact() async {
    try {
      final response = await _dio.get('https://api.api-ninjas.com/v1/facts');
      return response.data[0]['fact'];
    } on DioException catch (e) {
      print("Ошибка при получении факта: ${e.message}");
      return 'Error: ${e.response?.data ?? "Unknown error"}';
    } catch (e) {
      print("Неизвестная ошибка: $e");
      return 'Error: $e';
    }
  }

  Future<String> getJoke() async {
    try {
      final response = await _dio.get('https://api.api-ninjas.com/v1/jokes');
      return response.data[0]['joke'];
    } on DioException catch (e) {
      print("Ошибка при получении шутки: ${e.message}");
      return 'Error: ${e.response?.data ?? "Unknown error"}';
    } catch (e) {
      print("Неизвестная ошибка: $e");
      return 'Error: $e';
    }
  }
}

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<DioClient>(DioClient());
}
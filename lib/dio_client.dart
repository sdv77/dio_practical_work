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
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}

// Настройка GetIt
final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<DioClient>(DioClient());
}
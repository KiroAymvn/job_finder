
import 'package:dio/dio.dart';
import 'package:job_finder/core/utils/secure_storage_helper.dart';


class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {"Content-Type": 'application/json'},
    ),
  );

  DioClient() {
       //to see all the request and response from the backend

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storageHelper = await SecureStorageHelper.getInstance();
          final String? token = await storageHelper?.getData(key: "token");
          print(' API Request to: ${options.path}');
          print(' Token for request: ${token ?? 'null'}');

          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
            print('Authorization header added');
          } else {
            print('No authorization header added');
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}


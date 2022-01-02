import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterceptorCLiente extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    options.headers['Authorization'] = prefs.getString("token")!;
    super.onRequest(options, handler);
  }
}

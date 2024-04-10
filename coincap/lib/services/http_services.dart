import 'package:dio/dio.dart';
import 'package:coincap/models/app_config.dart';
import 'package:get_it/get_it.dart';

class HTTPServices {
  final Dio dio = Dio();

  AppConfig? appconfig;
  String? baseUrl;

  HTTPServices() {
    appconfig = GetIt.instance.get<AppConfig>();
    baseUrl = appconfig!.COIN_API_BASE_URL;
  }
// https://pro-api.coingecko.com/api/v3/
  Future<Response?> get(String path) async {
    try {
      String url = "${baseUrl}${path}";
      Response response = await dio.get(url);
      return response;
    } catch (e) {
      print('Unable to perform get request');
      print(e);
    }
  }
}

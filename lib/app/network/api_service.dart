import 'package:get/get.dart';

class ApiService extends GetConnect{


Future<Response> getCall(
    String url,
  ) async =>
      await get( url);
}
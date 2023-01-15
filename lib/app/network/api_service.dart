import 'package:get/get.dart';

class ApiService extends GetConnect{ 
//Didn't defined base url and headers here because we are using single API call in this project
//Created a new service class for the API call
Future<Response> getCall( 
    String url,
  ) async =>
      await get( url);
}
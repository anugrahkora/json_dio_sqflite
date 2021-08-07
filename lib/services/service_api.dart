import 'package:dio/dio.dart';
import 'package:json_dio_sqflite/models/service_model.dart';

class ServiceApi {
  var url = 'https://jsonplaceholder.typicode.com/users';

  var _dio = Dio();

  Future<List<Service>> fetchServiceApi() async {
    try {
      Response response = await _dio.get(url);
      
       return (response.data as List)
          .map((services) => Service.fromJson(services))
          .toList();
    
      
    } on DioError catch (e) {
      print(e.error);
    }
  }
}

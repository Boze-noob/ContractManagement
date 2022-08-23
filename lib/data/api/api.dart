import 'package:contract_management/_all.dart';

abstract class Api {
  Future<String?> delete(String path, Map<String, dynamic>? queryParameters);
}

class ApiImpl implements Api {
  final Dio dio;

  ApiImpl({required this.dio});

  @override
  Future<String?> delete(String path, Map<String, dynamic>? queryParameters) async {
    try {
      await dio.delete(path, queryParameters: queryParameters);
      return null;
    } on DioError catch (e) {
      return e.message;
    }
  }
}

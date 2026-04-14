import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8000",
      connectTimeout: const Duration(seconds: 5),
    ),
  );

  Future<List<Map<String, dynamic>>> getFoodTrucks({String? query}) async {
    final response = await _dio.get(
      "/food-trucks",
      queryParameters: query != null ? {"q": query} : null,
    );

    final data = response.data as List;

    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
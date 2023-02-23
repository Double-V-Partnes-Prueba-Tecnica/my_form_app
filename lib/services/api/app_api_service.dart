import 'package:http/http.dart' as http;
import 'package:my_form_app/services/constants/app_envirroment.dart';

class ApiResponse {
  final int status;
  final dynamic data;

  ApiResponse({required this.status, required this.data});
}

class AppApiService {
  static Future<ApiResponse> getHttp(String endpoint,
      {String? filter, bool? count}) async {
    String url = AppEnviroment().getApiURL + endpoint;
    if (filter != null) {
      url += '?filter=$filter';
    }
    if (count != null && count) {
      url += '/count';
    }
    try {
      final response = await http.get(Uri.parse(url));
      return ApiResponse(status: response.statusCode, data: response.body);
    } catch (e) {
      return ApiResponse(status: 500, data: e.toString());
    }
  }
}

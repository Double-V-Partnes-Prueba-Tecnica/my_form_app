import 'package:http/http.dart' as http;
import 'package:my_form_app/services/constants/app_envirroment.dart';

class ApiResponse {
  final int status;
  final dynamic data;

  ApiResponse({required this.status, required this.data});
}

class ApiService {
  // Get, puede recibir o no un filtro, o una variable booleana para indicar si se quiere un count
  static Future<ApiResponse> getHttp(String endpoint,
      {String? filter, bool? count}) async {
    // url
    String url = AppEnviroment().getApiURL + endpoint;
    // si se envía un filtro
    if (filter != null) {
      url += '?filter=$filter';
    }
    // si se envía un count agregar a la url /count
    if (count != null && count) {
      url += '/count';
    }
    try {
      // http get
      final response = await http.get(Uri.parse(url));
      return ApiResponse(status: response.statusCode, data: response.body);
    } catch (e) {
      // si hay un error, devolver el error
      return ApiResponse(status: 500, data: e.toString());
    }
  }
}

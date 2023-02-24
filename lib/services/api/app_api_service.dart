import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_form_app/services/constants/app_envirroment.dart';

class ApiResponse {
  final int status;
  final dynamic data;

  ApiResponse({required this.status, required this.data});
}

class AppApiService {
  static Future<ApiResponse> getHttp(
    String endpoint, {
    dynamic? filter,
    bool? count,
    String? token,
  }) async {
    String url = AppEnviroment().getApiURL + endpoint;

    if (count != null && count) {
      url += '/count';
    }

    if (filter != null) {
      // encode filter for url
      filter = jsonEncode(filter);
      url += '?filter=$filter';
    }
    try {
      if (token != null) {
        final headers = {'Authorization': 'Bearer $token'};
        final response = await http.get(Uri.parse(url), headers: headers);
        return ApiResponse(status: response.statusCode, data: response.body);
      } else {
        final response = await http.get(Uri.parse(url));
        return ApiResponse(status: response.statusCode, data: response.body);
      }
    } catch (e) {
      return ApiResponse(status: 500, data: e.toString());
    }
  }

  static Future<ApiResponse> postHttp(String endpoint, dynamic body,
      {String? token}) async {
    String url = AppEnviroment().getApiURL + endpoint;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
        },
        body: body,
      );
      return ApiResponse(status: response.statusCode, data: response.body);
    } catch (e) {
      return ApiResponse(status: 500, data: e.toString());
    }
  }
}

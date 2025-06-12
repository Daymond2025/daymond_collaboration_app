import 'dart:convert';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/recruteur.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> badge() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await user_services.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/getInfoById'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Recruteur.fromJson(jsonDecode(response.body));
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

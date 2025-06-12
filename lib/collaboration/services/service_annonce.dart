import 'dart:io';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceAnnonce {
  /////////////////// get user notification daymond regi
  Future getNotificationRegisDaymond() async {
    final token = await user_services.getToken();
    String myUrl = "${apiUrl}/getNotifyByUser";
    final response = await http.get(Uri.parse(myUrl), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }

  /////////////////// get user notification daymond audio
  Future<ApiResponse> getAudioNotificationDaymond() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/getNotifyByUser'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = json.decode(response.body);
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = json.decode(response.body)['message'];
          break;

        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      print('$e');
      apiResponse.error = somethingWentWrong;
    }

    return apiResponse;
  }

  //////////////////// READ AUDIO
  Future ReadAudio(String id_audio) async {
    final token = await user_services.getToken();
    String myUrl = "${apiUrl}/setLuAudio?id_audio=${id_audio}";
    var headers = {
      'Authorization': 'Bearer ${token}',
    };
    var request = http.Request('GET', Uri.parse('$myUrl'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

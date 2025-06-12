import 'dart:convert';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';

import 'package:http/http.dart' as http;

// GET ALL POSTs -------------------------------

Future<ApiResponse> getPosts() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await UserService().getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/recruiter/post'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data'];
        apiResponse.data as List<dynamic>;
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = 'serverError';
  }

  return apiResponse;
}

//Like ans noLike
Future<ApiResponse> likeNo(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await UserService().getToken();
    final response = await http.get(
        Uri.parse('$apiUrl/recruiter/post/$postId/like_on_unlike'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

//ShowCommentaire
Future<ApiResponse> showPoste(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await UserService().getToken();
    final response = await http.get(Uri.parse('$apiUrl/recruiter/post/$postId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data'];
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> storeCommentaire(int postId, String commentaire) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await UserService().getToken();
    final response = await http
        .post(Uri.parse('$apiUrl/recruiter/post/$postId/comment'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'comment': commentaire
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> deleteCommentaire(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await UserService().getToken();
    final response = await http.get(
      Uri.parse('$apiUrl/recruiter/comment/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;

      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;

      case 401:
        apiResponse.error = unauthorized;
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

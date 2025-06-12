// import 'dart:io';
import 'dart:math';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/Vendeur.dart';
// import 'package:collaboration/models/transaction_model.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceSeller {
  var StatusCode = 0;
  var Message = "";

  //////////////////////  code verification /////////
  Future<ApiResponse> getDetailsSeller(
    String id,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/showVendeurById/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Vendeur.fromJson(jsonDecode(response.body));
          break;
        case 422:
          apiResponse.error = jsonDecode(response.body)['message'];

          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }

////////////////////// login auth ////////////////
  Future<ApiResponse> AddSellersRequest(
    String nom,
    String prenom,
    String contact,
    String contact2,
    String ville,
    String profession,
    String password,
    String code_phone_verified,
  ) async {
    // print([nom, prenom, contact, contact2, ville, profession, password, code_phone_verified]);return null!;
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/recruiter/seller'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'first_name': nom,
          'last_name': prenom,
          'phone_number': contact,
          'ville': ville,
          'job': profession,
          'password': password,
          'city_id': ville,
          'code': code_phone_verified,
        },
      );

      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];

          break;
        case 201:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 422:
          apiResponse.error =
              "Mail ou le Numero de Telephone est deja utilise"; //jsonDecode(response.body)['message']
          print("erreur 422 ${jsonDecode(response.body)['message']} ");
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'].toString();
          break;
        default:
          // print(jsonDecode(response.body));
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }

  //////////////////////  code verification /////////
  Future<ApiResponse> SendCodeVerifyVendeurRequest(
    String contact,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();
    print([contact, token]);
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/register/send_sms'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'phone_number': contact,
        },
      );
      print(response.body);
      switch (response.statusCode) {
        //0704051151
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 422:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }

  //////////////////////  code verification /////////
  Future<ApiResponse> SendCodeVerifyRecruteurRequest(
    String email,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http
          .post(Uri.parse('$apiUrl/auth/register/send_mail?email=$email'));
      print('============SEND MAIL=============');
      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 422:
          // print('ok : ${jsonDecode(response.body)}');

          apiResponse.error = jsonDecode(response.body)['message'];
          print(
              "status code et erreur == ${response.statusCode} - ${apiResponse.error}");
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
      }
    } catch (e) {
      print(e.toString());
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }

  // ROMPRE LE LIEN
  Future<ApiResponse> rompreLienRequest(String id) async {
    ApiResponse apiResponse = ApiResponse();
    print(id);
    // return null!;
    try {
      final token = await user_services.getToken();
      final response = await http.put(
        Uri.parse('$apiUrl/recruiter/seller/$id/untie'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'id': id,
        },
      );
      switch (response.statusCode) {
        case 200:
          print(response.body);
          apiResponse.data = json.decode(response.body)['message'];
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

  ///////////////////////// generate password ///////////////////
  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    final length = 20;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }

  ////////////////////// getting seller //////////////
  Future getSeller() async {
    String token = await user_services.getToken();
    String myUrl = "$apiUrl/recruiter/seller?broken_link=false";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Response response =
        await Dio().get(myUrl, options: Options(headers: headers));
    print(response.data);
    if (response.statusCode == 200) {
      var jsonResponse = response.data['data'];
      return jsonResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }

  ////////////////////// getting seller //////////////
  Future getSellerLienRompus() async {
    String token = await user_services.getToken();
    String myUrl = "$apiUrl/recruiter/seller?broken_link=true";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Response response =
        await Dio().get(myUrl, options: Options(headers: headers));

    if (response.statusCode == 200) {
      var jsonResponse = response.data['data'];
      return jsonResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }

  ////////////////////// products sellers ////////////////
  Future<ApiResponse> CommandesBySeller(String id) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/recruiter/transactions?seller_id=3'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      Map<String, dynamic> data = json.decode(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = data['data'];
          break;
        case 422:
          apiResponse.error = jsonDecode(response.body)['message'];

          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }

  Future CommissionByRecruteur() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/recruiter/transactions?category=commission'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data'];
          // apiResponse.data as List<dynamic>;
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
      apiResponse.error = somethingWentWrong;
    }

    return apiResponse;
  }
}

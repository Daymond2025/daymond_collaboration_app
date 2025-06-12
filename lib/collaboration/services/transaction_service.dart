import 'dart:convert';
// import 'dart:io';

import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/ContactTransaction.dart';
// import 'package:collaboration/models/TransactionRetrait.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  //portefeuille
  Future<ApiResponse> getBalanceUser() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/recruiter/wallet'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body);
          apiResponse.data as dynamic;
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

  //transaction
  Future<ApiResponse> getAllTransactions() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/recruiter/transactions?category=withdrawal'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data'];

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

  //numero de transaction
  Future<ApiResponse> getAllContactTransactions() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await user_services.getToken();
      final response = await http.get(
        Uri.parse('$apiUrl/getAllContactTransactions'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          // print(jsonDecode(response.body));
          apiResponse.data = jsonDecode(response.body)['contacts']
              .map<ContactTransaction>(
                  (json) => ContactTransaction.fromJson(json))
              .toList();
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

  //add numeri de transaction
  Future<ApiResponse> addContacts(String numero, String operateur) async {
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();
    try {
      final response = await http.post(
        Uri.parse("${apiUrl}/addContactTransaction"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {'numero': numero, 'operateur': operateur},
      );
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;

        case 422:
          final errors = jsonDecode(response.body)['message'];
          apiResponse.error = errors[errors.keys.elementAt(0)]; //[0];
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

  Future<ApiResponse> demandeRetraits(
    String montant_retrait,
    String numero_retrait,
    String operateur_retrait,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    // print("====================DEMANDE RETRAIT====================");
    // print([montant_retrait, numero_retrait, operateur_retrait]);
    // return null!;
    try {
      final token = await user_services.getToken();
      // String type = 'retrait';
      final response = await http.post(
        Uri.parse("$apiUrl/recruiter/payment/withdrawal"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: {
          'phone_number': numero_retrait,
          'amount': montant_retrait,
          'operator': operateur_retrait
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['status_code'];
          break;

        case 422:
          final errors = jsonDecode(response.body)['message'];
          apiResponse.error = errors[errors.keys.elementAt(0)];
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
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:http/http.dart' as http;

import 'package:daymond_collaboration_app/collaboration/const/contants.dart';

class ServiceBadgeCertifie {
  var statusCode = 0;

  Future<ApiResponse> DemandeBadgeCerifie(
    String lieuxLivraison,
    String contact1,
    String contact2,
    String id_transaction,
    String amount,
    String status,
    String currency,
    String payment_method,
    String description,
    String operator_id,
    String customer_country,
    String payment_date,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/demandeBadgeCertifies'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {
          'lieux_livraison': lieuxLivraison,
          'contact1': contact1,
          'contact2': contact2,
          'id_transaction': id_transaction,
          'amount': amount,
          'status': status,
          'currency': currency,
          'payment_method': payment_method,
          'description': description,
          'operator_id': operator_id,
          'customer_country': 'CI',
          'payment_date': payment_date,
        },
      );

      switch (response.statusCode) {
        case 200:
          var resultats = jsonDecode(response.body);
          statusCode = response.statusCode;

          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)]; //[0];
          break;
        case 403:
          apiResponse.error = response.body;
          break;
        default:
          apiResponse.error = "quelque chose s'est produite";
          break;
      }
    } catch (e) {
      print('error:::: $e');
      apiResponse.error = 'Erreur du serveur';
    }
    return apiResponse;
  }

  ///////////////////: VALIDER BADGE CERTIFIE /////////////
  Future<ApiResponse> ValiderBadge(
    String code_bagde,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/validerBadge'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: {
          'code_bagde': code_bagde,
        },
      );
      switch (response.statusCode) {
        case 200:
          var resultats = jsonDecode(response.body);
          statusCode = response.statusCode;

          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)]; //[0];
          break;
        case 403:
          apiResponse.error = response.body;
          break;
        default:
          apiResponse.error = "quelque chose s'est produite";
          break;
      }
    } catch (e) {
      print('error:::: $e');
      apiResponse.error = 'Erreur du serveur';
    }
    return apiResponse;
  }
}

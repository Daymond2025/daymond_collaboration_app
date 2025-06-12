import 'dart:convert';
import 'dart:io';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/Vendeur.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/provider/dio_repository.dart';
// import 'package:collaboration/models/recruteur.dart';
import 'package:dio/dio.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  var StatusCode = 0;
////////////////////// login auth ////////////////
  Future<ApiResponse> Login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    FormData formData =
        FormData.fromMap({'email': email, 'password': password});
    try {
      Response response = await Dio().post(
        "${apiUrl}/auth/recruiter/login",
        data: formData,
      );

      // print('============LOGIN=============');

      switch (response.statusCode) {
        case 200:
          // print('recruter : ${response.data['data']}');
          apiResponse.data = RecruterLoginModel.fromJson(response.data['data']);

          break;
        case 422:
          final errors = response.data['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)];
          break;
        case 403:
          apiResponse.error = response.data['message'];
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

  Future<ApiResponse> AddRecruteurRequest(
    String nom,
    String prenom,
    String ville,
    String contact,
    String job,
    String email,
    String password,
    String code_phone_verified,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    FormData formData = FormData.fromMap({
      'first_name': nom,
      'last_name': prenom,
      'phone_number': contact,
      'city_id': ville,
      'job': job,
      'email': email,
      'password': password,
      'code': code_phone_verified,
    });
    try {
      Response response = await Dio().post(
        '$apiUrl/auth/recruiter/register',
        data: formData,
      );
      // print(response.data);
      switch (response.statusCode) {
        case 200:
          print("succes ${response.statusCode}");
          apiResponse.data = RecruterLoginModel.fromJson(response.data['data']);

          break;
        case 422:
          print("erreur ${response.statusCode}");
          final errors = response.data['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)];
          break;
        case 403:
          print("erreur ${response.statusCode}");
          apiResponse.error = response.data['message'];
          break;
        default:
          print("erreur ${response.statusCode}");
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      print("erreur ${e.toString()}");
      apiResponse.error = somethingWentWrong;
    }
    return apiResponse;
  }

  Future<ApiResponse> updateUserAccount(
    String nom,
    String prenom,
    String job,
    String ville,
    String contact,
    String email,
    File image,
  ) async {
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();

    // print(ville);

    try {
      // final response = await http.put(
      //   Uri.parse('$apiUrl/recruiter/update'),
      //   headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      //   body: {
      //     'first_name': '${nom}',
      //     'last_name': '${prenom}',
      //     'job': "${job}",
      //     'ville': '1',
      //     'phone_number': '${contact}',
      //     'email': '${email}',
      //     'picture_path': '${image}',
      //   },
      // );

      // Create a multipart request
      var request =
          http.MultipartRequest('POST', Uri.parse("$apiUrl/recruiter/update"));

      // Add fields
      request.fields['first_name'] = '${nom}';
      request.fields['last_name'] = '${prenom}';
      request.fields['job'] = "${job}";
      request.fields['city_id'] = '1';
      request.fields['phone_number'] = '${contact}';
      request.fields['email'] = '${email}';

      // Attach the file
      request.files
          .add(await http.MultipartFile.fromPath('picture_path', image.path));

      // Add headers
      request.headers.addAll({
        HttpHeaders.authorizationHeader: "Bearer $token",
      });

      // Send the request
      var response = await request.send();

      // print("============UPDATE PROFILE=============");
      // print(response.stream);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = 'Profile modifié avec succès.';
          break;
        case 422:
          final errors = "Erruers";
          apiResponse.error = errors; //[0];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        case 403:
          apiResponse.error = 'Failed'; //jsonDecode(response.body)['message'];
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

  ///////////////////// delete user compte
  Future<ApiResponse> DeleteUserAcount() async {
    ApiResponse apiResponse = ApiResponse();
    final token = await user_services.getToken();
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/deleteCompte'),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      switch (response.statusCode) {
        case 200:
          var resultats = jsonDecode(response.body);
          StatusCode = response.statusCode;

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

  ////////////// forget password send mail verification //////////////
  Future<ApiResponse> SendEmailToRessetPassword(String email) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v2/auth/recruiter/send-otp'),
        headers: {'Accept': 'application/json'},
        body: {'email': email},
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data'];
          break;
        case 422:
          apiResponse.error = "Adresse email invalide";
          break;
        case 404:
          apiResponse.error = "Cette adresse n'est associée à aucun compte";
          break;
        default:
          apiResponse.error = jsonDecode(response.body)['message'] ??
              "Une erreur s'est produite";
      }
    } catch (e) {
      apiResponse.error = "Erreur de connexion au serveur";
    }
    return apiResponse;
  }

// Future<ApiResponse> SendEmailToRessetPassword(String email) async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     final response = await http.post(
//       Uri.parse('$apiUrl/seller/reset_password'),
//       headers: {'Accept': 'application/json'},
//       body: {
//         'email': email,
//       },
//     );

//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = jsonDecode(response.body);
//         break;
//       case 422:
//         final errors = jsonDecode(response.body)['errors'];
//         apiResponse.error = errors[errors.keys.elementAt(0)];
//         break;
//       case 403:
//         apiResponse.error = response.body;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     print('Erreur : $e');
//     apiResponse.error = 'Erreur du serveur';
//   }
//   return apiResponse;
// }

  ////////////////// resset password verify code //////////////
  Future<ApiResponse> SendRessetCodeVerify(
      String email, String code_verified) async {
    print("====le code est $code_verified");
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/recruiter/verify-otp-reset-password'),
        headers: {'Accept': 'application/json'},
        body: {
          'email': '${email}',
          'otp': code_verified,
        },
      );
      print("reponse status code ${response.statusCode}");
      switch (response.statusCode) {
        case 200:
          var resultats = jsonDecode(response.body);
          apiResponse.data = jsonDecode(response.body);
          StatusCode = response.statusCode;
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)]; //[0];
          break;
        case 403:
          apiResponse.error = response.body;
          break;
        default:
          print("status code == ${response.statusCode}");
          apiResponse.error = "quelque chose s'est produite";
          break;
      }
    } catch (e) {
      print('error:::: $e');
      apiResponse.error = 'Erreur du serveur';
    }
    return apiResponse;
  }

  ////////////////// resset password verify code //////////////
  Future<ApiResponse> UpdatePasswordReequest(
      String email, String code_verified, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/recruiter/update-password'),
        headers: {'Accept': 'application/json'},
        body: {
          'email': '${email}',
          'old_password': '${code_verified}',
          'new_password': '${password}',
          'new_password_confirmation': '${password}'
        },
      );

      switch (response.statusCode) {
        case 200:
          var resultats = jsonDecode(response.body);
          StatusCode = response.statusCode;
          print("status code == ${response.statusCode}");

          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          StatusCode = response.statusCode;
          apiResponse.error = errors[errors.keys.elementAt(0)]; //[0];
          print("status code == ${response.statusCode}");
          break;
        case 403:
          apiResponse.error = response.body;
          StatusCode = response.statusCode;
          print("status code == ${response.statusCode}");
          break;
        default:
          print("status code == ${response.statusCode}");
          apiResponse.error = "quelque chose s'est produite";
          break;
      }
    } catch (e) {
      print('error:::: $e');
      apiResponse.error = 'Erreur du serveur';
    }
    return apiResponse;
  }

  // Detail User -------------------------------
  Future<ApiResponse> getUserDetail() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      print("==================USER DETAI $token====================");
      Response response = await DioRepository.instance
          .apiRepository(token)
          .get('$apiUrl/recruiter/detail');
      // Response response = await Dio(BaseOptions(
      //   baseUrl: apiUrl,
      //   headers: headers,
      //   responseType: ResponseType.json,
      //   contentType: 'application/json',
      //   receiveDataWhenStatusError: true,
      //   validateStatus: (status) {
      //     return status! < 500;
      //   },
      // )).get(
      //   '$apiUrl/recruiter/detail',
      // );
      print("==================USER DETAIL ====================");
      print([response, response.statusCode]);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = RecruterFindModel.fromJson(response.data['data']);
          // print(RecruterFindModel.fromJson(response.data['data']));
          break;

        case 403:
          apiResponse.error = response.data['message'];
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

  Future<ApiResponse> getVendeurInfos(String id) async {
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
          apiResponse.data as Vendeur;

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

  //FUNCTION UPDATE USER PICTURE
  Future updateUserPicture(String photo) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final token = await user_services.getToken();
      var headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/updateUsersPhoto'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('photo_profil', '${photo}'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      switch (response.statusCode) {
        case 200:
          apiResponse.data = 'Photo de profil changé.';
          break;

        case 403:
          apiResponse.error = 'Echec lors de la transmission';
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

  ///////////////// get user balance /////
  Future<ApiResponse> getBalance() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      String token = await user_services.getToken();

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      Response response = await Dio().get(
        '$apiUrl/recruiter/wallet',
        options: Options(
          headers: headers,
        ),
      );
      // print('==============GET BALANCE =========');
      // print(response.data);
      // final response =
      //     await http.get(Uri.parse('$apiUrl/recruiter/wallet'), headers: {
      //   HttpHeaders.authorizationHeader: "Bearer $token"
      // });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = response.data;

          break;

        case 401:
          apiResponse.error = unauthorized;

          break;
        case 403:
          apiResponse.error = response.data['message'];

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

  //////////////////// get user token ///////////
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  Future<String> getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('role_as') ?? '';
  }

//////////////////// get user id ///////////
  Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 0;
  }

///////////////// get users VERIF_STATUS /////////////////
  Future<String> getVerifyStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('VERIF_STATUS') ?? '';
  }

// logout
  Future<bool> logout() async {
    String token = await getToken();
    await http.post(Uri.parse('$apiUrl/logout'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('userId');
    return await pref.remove('token');
  }
}

import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:get/get.dart';

class ServiceCity extends GetConnect{

  @override
  void onInit() {
    httpClient.baseUrl = apiUrl;
    super.onInit();
  }

  //////////////// getting city //////////////

  Future<Response<List<CityModel>>> getCities() => get('/params/data?option=city', decoder: (cities)=> List<CityModel>.from(cities['data'].map((x) => CityModel.fromJson(x))));

}
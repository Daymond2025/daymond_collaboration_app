import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_path.dart';
import 'package:get/get.dart';

class CityController  extends GetxController{
  final cityLoading = false.obs;
  List<CityModel> cities = [];

  final ServiceCity serviceCity = ServiceCity();

  @override
  void onInit() {
    super.onInit();
    serviceCity.onInit();
    getCities();
  }

 Future <void> getCities() async {
    cityLoading(true);
    try{
      final response = await serviceCity.getCities();
      if(response.statusCode == 200){
        cities = response.body!;
        cityLoading(false);
      }else{
        cityLoading(false);
      }
    }finally{
      cityLoading(false);
    }
 }
}
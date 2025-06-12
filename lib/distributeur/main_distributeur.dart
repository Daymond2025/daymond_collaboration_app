import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'constants/app_pages.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'services/initial.dart';

void main() async {
  //var result = await BarcodeScanner.scan();
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialise correctement la locale
  await initializeDateFormatting('fr_FR', null);
  Intl.defaultLocale = 'fr_FR';
  // TEST
  print(DateFormat('MMMM').format(DateTime.now())); // Devrait afficher le mois en FR sans crash

  // Initialiser GetStorage
  await GetStorage.init();
  runApp(const DistributeurApp());
}

class DistributeurApp extends StatelessWidget {
  const DistributeurApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final hasSeenIntro = box.read('onboarding_seen') ?? false;

    return GetMaterialApp(
      title: 'Daymond App',
      debugShowCheckedModeBanner: false,
      initialRoute: hasSeenIntro ? Routes.bigin : Routes.onboarding,
      getPages: AppPages.routes,
      initialBinding: StoreBinding(),
      builder: EasyLoading.init(),
    );
  }
}

import 'package:water_azaz_project/config/routes/unknown_route.dart';
import 'package:get/get.dart';

class Routes {
  Routes._();

  static GetPage<dynamic> notFound = GetPage(
    name: '/notFound',
    page: () => const UnknownRoute(),
  );

  static List<GetPage<dynamic>> getPages = [
    
  ];
 
  
}

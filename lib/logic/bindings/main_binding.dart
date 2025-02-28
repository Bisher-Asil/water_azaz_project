//import 'package:chargin/logic/controllers/account_ctrl.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';

import '../../config/routes/routes.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<WaterQualityController>(WaterQualityController());
  }
}

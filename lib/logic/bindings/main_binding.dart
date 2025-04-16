//import 'package:chargin/logic/controllers/account_ctrl.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/feedback_ctrl.dart';
import 'package:water_azaz_project/logic/controllers/water_flow_ctrl.dart';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';
import 'package:water_azaz_project/services/auth_service.dart';

//import '../../config/routes/routes.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService());
    Get.put<WaterQualityController>(WaterQualityController());
    Get.put<WaterFlowController>(WaterFlowController());
    Get.put<FeedbackController>(FeedbackController());
  }
}

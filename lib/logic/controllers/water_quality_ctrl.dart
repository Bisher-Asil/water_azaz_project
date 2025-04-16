import 'package:get/get.dart';
import 'package:water_azaz_project/services/auth_service.dart';
import 'package:water_azaz_project/services/quality_service.dart';

class WaterQualityController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  
  var waterColor = ''.obs;
  var waterTaste = ''.obs;

  
  var otherWaterColor = ''.obs;
  var otherWaterTaste = ''.obs;
  

  void postWaterQualityFeedback() async{
    String? token = await authService.getToken();
    if(token == null) {
      Get.snackbar("Error", "User not authenticated");
      return;
    }
    String sendWaterColor = waterColor.value == 'أخرى' ? otherWaterColor.value : waterColor.value;
    String sendWaterTaste = waterTaste.value ==  'طعم آخر' ? otherWaterTaste.value : waterTaste.value;
    if(sendWaterColor.isEmpty || sendWaterTaste.isEmpty) {
      Get.snackbar("خطأ", "يرجى ملء جميع الحقول");
      return;
    }
    bool success = await QualityService.postWaterQuality(token, sendWaterColor, sendWaterTaste);
    if(success) {
      Get.snackbar("نجحت العملية", "تم ارسال رأيكم بنجاح");
    } else {
      Get.snackbar("خطأ", "يرجى المحاولة لاحقاً");
    }
  }

  
}
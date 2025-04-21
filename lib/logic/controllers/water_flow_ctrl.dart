import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/services/auth_service.dart';
import 'package:water_azaz_project/services/flow_service.dart';
import 'package:water_azaz_project/ui/widgets/thank_you_dialog.dart';

class WaterFlowController extends GetxController {
  AuthService authService = Get.find<AuthService>();
  var waterFrequency = ''.obs;
  var waterFrequencySuggestion = ''.obs;


  var waterSufficiency = ''.obs;
  var flowSuggestion = ''.obs;

  // Observable variables
  void postWaterFlowFeedback(BuildContext context) async {
    String? token = await authService.getToken();
    if(token == null) {
      Get.snackbar("خطأ", "يرجى تسجيل الدخول أولاً");
      return;
    }
    if(waterFrequency.value.isEmpty || waterFrequencySuggestion.value.isEmpty) {
      Get.snackbar("خطأ", "يرجى ملء جميع الحقول");
      return;
    }
    String sentWaterFrequency = waterFrequency.value ==  'غير ذلك (يرجى الشرح)' ? waterFrequencySuggestion.value : waterFrequency.value;
    String sentWaterSufficiency = waterSufficiency.value == 'لا' ? flowSuggestion.value : waterFrequencySuggestion.value;
    bool success = await FlowService.postWaterFlow(token, sentWaterFrequency, sentWaterSufficiency);
    if(success) {
      if(context.mounted){
        showThankYouDialog(context);
      }
      Get.snackbar("نجحت العملية", "تم ارسال رأيكم بنجاح");
    } else {
      Get.snackbar("خطأ", "حصل خطأ أثناء ارسال رأيكم, يرجى المحاولة لاحقاً");
    }
  }

}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_azaz_project/services/auth_service.dart';
import 'package:water_azaz_project/services/feedback_service.dart';
import 'package:water_azaz_project/ui/widgets/thank_you_dialog.dart';

class FeedbackController extends GetxController {
  AuthService authService = Get.find<AuthService>();

  var complaintType = ''.obs;
  var complaintDescription = ''.obs;
  var showAttachedMedia = false.obs;
  var attachedMedia = Rx<File?>(null);
  

  void postFeedback(BuildContext context) async{
    String? token = await authService.getToken();
    if(token == null) {
      Get.snackbar("Error", "User not authenticated");
      return;
    }
    if(complaintType.value.isEmpty || complaintDescription.value.isEmpty) {
      Get.snackbar("خطأ", "يرجى ملء جميع الحقول");
      return;
    }

    var success = await FeedbackService.postFeedback(token, complaintType.value +" : " + complaintDescription.value,  attachedMedia.value);
    if(success) {
      if(context.mounted){
        showThankYouDialog(context);
      }
      Get.snackbar("نجحت العملية", "تم ارسال الشكوى بنجاح");
    } else {
      Get.snackbar("خطأ", "فشلت العملية, يرجى المحاولة لاحقاً");
    }  
  }
  
  Future<void> pickMedia() async {
  final ImagePicker picker = ImagePicker();

  // Let the system handle media selection (photo or video)
  final XFile? file = await picker.pickMedia();

  if (file != null) {
    attachedMedia.value = File(file.path);
    showAttachedMedia.value = true;
    // Use the selected media file as needed
  } else {
    print("No media selected.");
  }
}


}
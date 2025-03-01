
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WaterQualityController extends GetxController {
  var waterColor = ''.obs;
  var waterTaste = ''.obs;
  var waterFrequency = ''.obs;
  var pumpingHours = ''.obs;
  var complaintType = ''.obs;
  var complaintDescription = ''.obs;
  var attachedMedia = Rx<XFile?>(null);

  var otherWaterColor = ''.obs;
  var otherWaterTaste = ''.obs;

  Future<void> pickMedia() async {
  final ImagePicker picker = ImagePicker();

  // Let the system handle media selection (photo or video)
  final XFile? file = await picker.pickMedia();

  if (file != null) {
    File mediaFile = File(file.path);
    print("Media picked: ${mediaFile.path}");
    
    // Use the selected media file as needed
  } else {
    print("No media selected.");
  }
}
}

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

  void pickMedia()  {
    
  }
}
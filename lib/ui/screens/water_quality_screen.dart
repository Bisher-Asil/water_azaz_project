import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';

class WaterQualityScreen extends StatelessWidget {
  const WaterQualityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaterQualityController controller = Get.find();
    final TextEditingController otherWaterColorCtrl = TextEditingController();
    final TextEditingController otherWaterTasteCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('تقييم جودة المياه'),centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'لون المياه'),
                items: ['شفافة', 'صفراء', 'بنية', 'سوداء', 'أخرى']
                    .map((e) => DropdownMenuItem(value: e, child: Align(
              alignment: Alignment.centerRight, // Align text to the right
              child: Text(e, textDirection: TextDirection.rtl),
            ),))
                    .toList(),
                onChanged: (value) => controller.waterColor.value = value!,
              ),
            ),
            Obx(() => controller.waterColor.value == 'أخرى'
                ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    textDirection: TextDirection.rtl,
                      controller: otherWaterColorCtrl,
                      decoration: const InputDecoration(labelText: 'حدد اللون'),
                      onChanged: (value) => controller.otherWaterColor.value = value,
                    ),
                )
                : const SizedBox()),

            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'طعم المياه'),
                items: ['عديم الطعم', 'طعم كلور قوي', 'طعم معدني', 'طعم آخر']
                    .map((e) => DropdownMenuItem(value: e, child: Align(
                alignment: Alignment.centerRight, // Align text to the right
                child: Text(e, textDirection: TextDirection.rtl),
              ),))
                    .toList(),
                onChanged: (value) => controller.waterTaste.value = value!,
              ),
            ),
            Obx(() => controller.waterTaste.value == 'طعم آخر'
                ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    textDirection: TextDirection.rtl,
                      controller: otherWaterTasteCtrl,
                      decoration: const InputDecoration(labelText: 'حدد الطعم'),
                      onChanged: (value) => controller.otherWaterTaste.value = value,
                    ),
                )
                : const SizedBox()),
                            ElevatedButton(
              onPressed: () => print("WOW"),
              child: const Text('إرسال التقييم'),),
          ],
        ),
      ),
    );
  }
}
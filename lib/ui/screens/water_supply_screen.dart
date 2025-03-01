
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';

class WaterSupplyScreen extends StatelessWidget {
  const WaterSupplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaterQualityController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('تقييم مدة الضخ'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'كم مرة تصلكم المياه أسبوعيًا؟'),
                items: ['يوميًا', 'ثلاث مرات في الأسبوع', 'مرة في الأسبوع', 'أقل من ذلك']
                    .map((e) => DropdownMenuItem(value: e, child: Align(
              alignment: Alignment.centerRight, // Align text to the right
              child: Text(e, textDirection: TextDirection.rtl),
            ),))
                    .toList(),
                onChanged: (value) => controller.waterFrequency.value = value!,
              ),
            ),

            Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(labelText: 'كم عدد الساعات التي تحتاجها؟'),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.pumpingHours.value = value,
              ),
            ),
             const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => print("WOW"),
              child: const Text('إرسال التقييم'),),
          ],
        ),
      ),
    );
  }
}

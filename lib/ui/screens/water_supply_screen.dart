import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';
import 'package:water_azaz_project/ui/widgets/thank_you_dialog.dart';

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
                items: [
                  'يوميًا',
                  'ثلاث مرات في الأسبوع',
                  'مرة في الأسبوع',
                  'مرة كل أسبوعين',
                  'غير ذلك (يرجى الشرح)'
                ].map((e) => DropdownMenuItem(
                  value: e,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(e, textDirection: TextDirection.rtl),
                  ),
                )).toList(),
                onChanged: (value) => controller.waterFrequency.value = value!,
              ),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'هل يبلي هذا احتياجكم من المياه؟'),
                items: ['نعم', 'لا'].map((e) => DropdownMenuItem(
                  value: e,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(e, textDirection: TextDirection.rtl),
                  ),
                )).toList(),
                onChanged: (value) => controller.waterSufficiency.value = value!,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.waterSufficiency.value == 'لا') {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    decoration: const InputDecoration(labelText: 'كيف برأيكم يجب ان يكون تواتر ضخ المياه عبر الشبكة؟',labelStyle: TextStyle(fontSize: 14)),
                    onChanged: (value) => controller.flowSuggestion.value = value,
                  ),
                );
              } else {
                return Container();
              }
            }),
            ElevatedButton(
              onPressed: () {
                if (controller.waterSufficiency.value == 'لا') {
                  // Handle the submission for 'لا'
                  print("Suggestion: ${controller.flowSuggestion.value}");
                } else {
                  // Handle the submission for 'نعم'
                  print("Water Frequency: ${controller.waterFrequency.value}");
                  print("Water Sufficiency: ${controller.waterSufficiency.value}");
                }
                showThankYouDialog(context);
              },
              child: const Text('ارسال التقييم'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaterQualityController controller = Get.find();
    
    // Controllers for "other" inputs
    final TextEditingController otherWaterColorCtrl = TextEditingController();
    final TextEditingController otherWaterTasteCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('تقييم جودة المياه')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('تقييم جودة المياه', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            
            // Water Color Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'لون المياه'),
              items: ['شفافة', 'صفراء', 'بنية', 'سوداء', 'أخرى']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e))) 
                  .toList(),
              onChanged: (value) {
                controller.waterColor.value = value!;
              },
            ),
            Obx(() => controller.waterColor.value == 'أخرى'
                ? TextField(
                    controller: otherWaterColorCtrl,
                    decoration: InputDecoration(labelText: 'حدد اللون'),
                    onChanged: (value) => controller.otherWaterColor.value = value,
                  )
                : SizedBox()),

            // Water Taste Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'طعم المياه'),
              items: ['عديم الطعم', 'طعم كلور قوي', 'طعم معدني', 'طعم آخر']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                controller.waterTaste.value = value!;
              },
            ),
            Obx(() => controller.waterTaste.value == 'طعم آخر'
                ? TextField(
                    controller: otherWaterTasteCtrl,
                    decoration: InputDecoration(labelText: 'حدد الطعم'),
                    onChanged: (value) => controller.otherWaterTaste.value = value,
                  )
                : SizedBox()),

            SizedBox(height: 20),
            Text('تقييم مدة الضخ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // Water Frequency Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'كم مرة تصلكم المياه أسبوعيًا؟'),
              items: ['يوميًا', '3 مرات في الأسبوع', 'مرة في الأسبوع', 'أقل من ذلك']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => controller.waterFrequency.value = value!,
            ),

            // Pumping Hours Input
            TextField(
              decoration: InputDecoration(labelText: 'كم عدد الساعات التي تحتاجها؟'),
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.pumpingHours.value = value,
            ),

            SizedBox(height: 20),
            Text('إرسال شكوى', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // Complaint Type Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'نوع الشكوى'),
              items: [
                'مشكلة بلون المياه',
                'مشكلة بطعم المياه',
                'مشكلة في ساعات التشغيل',
                'مشكلة أخرى'
              ]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                controller.complaintType.value = value!;
              },
            ),

            // Complaint Description Input
            TextField(
              decoration: InputDecoration(labelText: 'وصف المشكلة'),
              onChanged: (value) => controller.complaintDescription.value = value,
            ),

            // Attach Media Button
            ElevatedButton(
              onPressed: () => controller.pickMedia(),
              child: Text('إرفاق صورة / فيديو'),
            ),

            // Display Attached Media
            Obx(() => controller.attachedMedia.value != null
                ? Image.file(File(controller.attachedMedia.value!.path))
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}

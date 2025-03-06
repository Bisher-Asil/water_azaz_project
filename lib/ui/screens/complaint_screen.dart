import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/water_quality_ctrl.dart';
import 'package:water_azaz_project/ui/widgets/thank_you_dialog.dart';


class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaterQualityController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('إرسال شكوى'),centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'نوع الشكوى'),
                items: [
                  'مشكلة بلون المياه',
                  'مشكلة بطعم المياه',
                  'مشكلة في ساعات التشغيل',
                  'مشكلة أخرى'
                ]
                    .map((e) => DropdownMenuItem(value: e, child: Align(
              alignment: Alignment.centerRight, // Align text to the right
              child: Text(e, textDirection: TextDirection.rtl),
            ),))
                    .toList(),
                onChanged: (value) => controller.complaintType.value = value!,
              ),
            ),

            Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(labelText: 'وصف المشكلة',hintTextDirection: TextDirection.rtl),
                onChanged: (value) => controller.complaintDescription.value = value,
              ),
            ),

            ElevatedButton(
              onPressed: () => controller.pickMedia(),
              child: const Text('إرفاق صورة / فيديو'),
            ),

            Obx(() => controller.attachedMedia.value != null
                ? Image.file(File(controller.attachedMedia.value!.path))
                : const SizedBox()),
                            ElevatedButton(
              onPressed: () => showThankYouDialog(context), //TODO: Make this appear in the controller not here...
              child: const Text('إرسال التقييم'),),
          ],
        ),
      ),
    );
  }
}
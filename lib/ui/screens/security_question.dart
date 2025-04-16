import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';

class SecurityQuestionScreen extends StatelessWidget {
  const SecurityQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.find();
    final String securityQuestion = Get.arguments;
    final TextEditingController answerController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Answer Security Question'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الرجاء الإجابة على السؤال الأمني'.tr,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            if (securityQuestion.isNotEmpty)
          Text(
                  securityQuestion.isNotEmpty
                      ?  securityQuestion
                      : 'يرجى المحاولة لاحقا'.tr,
                  style: const TextStyle(fontSize: 16.0),
                ),
            const SizedBox(height: 16.0),
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                labelText: 'الجواب',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: ()  {
                  final answer = answerController.text;
                  if (answer.isNotEmpty) {
                     accountController.verifySecurityQuestion(accountController.phoneNumber.value, answer);
                  } else {
                    Get.snackbar('خطأ', 'يرجى إدخال الجواب');
                  }
                },
                child: Text('ادخال الجواب'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
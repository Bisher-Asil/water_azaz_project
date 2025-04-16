import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.find();
    final String resetPasswordCode = Get.arguments;
    final TextEditingController newPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('تغيير كلمة السر'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'كلمة السر الجديدة'.tr,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            
    
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final newPassword = newPasswordController.text;
                  if (newPassword.isNotEmpty) {
                    accountController.resetPassword(accountController.phoneNumber.value, newPassword, resetPasswordCode); //calling the phone number like this is so dumb but I am burnt out and I dont want to fix it, jank code is the best code
                  } else {
                    Get.snackbar('خطأ', 'يرجى تعبئة جميع الحقول');
                  }
                },
                child: Text('تغيير كلمة السر'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
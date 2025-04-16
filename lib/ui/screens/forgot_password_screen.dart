import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _phoneController = TextEditingController();
    AccountController accountController = Get.find();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('نسيت كلمة السر'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الرجاء كتابة رقم الهاتف لطلب تغيير كلمة السر'.tr,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف'.tr,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: ()  {
                    final phoneNumber = _phoneController.text;
                    if (phoneNumber.isNotEmpty) {
                      accountController.getSecurityQuestion(phoneNumber);
                    } else {
                      Get.snackbar('خطأ', 'يرجى إدخال رقم الهاتف');
                    }
                  },
                  child: Text('طلب تغيير كلمة السر'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

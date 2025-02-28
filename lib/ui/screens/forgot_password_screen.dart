import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    AccountController accountController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email to request a password reset:'.tr,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email'.tr,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: () => accountController.passwordResetRequest(_emailController.text.isEmail? _emailController.text : ""),
                child: Text('Request Password Reset'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

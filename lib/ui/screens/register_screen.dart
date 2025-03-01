import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  final AccountController accountController = Get.find();
  final _NameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
    return Obx(() => Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
              child: Image.asset(
                'assets/images/logo.png', // Replace with your logo asset path
                height: 150.0,
              ),
            ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'الإسم'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال الإسم الثلاثي';
                          }
                          return null;
                        },
                        controller: _NameController,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'رقم الهاتف'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال رقم الهاتف';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      accountController.signInStatus.value ? TextFormField(
                        decoration: InputDecoration(
                          labelText: 'كلمة السر',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال كلمة السر'.tr;
                          }
                          return null;
                        },
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                      ) : Container(),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text('انا اقبل في التعليمات و الشروط'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle form submission here
                            var fullName = _NameController.text;
                            var phone =  _phoneController.text;
                            var password = _passwordController.text;
                            accountController.registerUserRequest(fullName,phone,password); //TODO: DONT FORGET TO ADD GPS
                          }
                        },
                        child: Text(accountController.signInStatus.value ? "تأكيد التعديل" : 'تسجيل'),
                      ),
                     // accountController.signInStatus.value ? ElevatedButton(onPressed: ()=> accountController.deleteUserRequest(_passwordController.text), child: Text("حذف الحساب")) : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

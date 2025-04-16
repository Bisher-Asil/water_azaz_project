import 'package:water_azaz_project/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';

class SignInScreen extends StatelessWidget {

  const SignInScreen({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    var accountController = Get.put<AccountController>(AccountController(), permanent: true);
    final TextEditingController usernameController = TextEditingController(text: accountController.savedUsername.value);
    final TextEditingController passwordController = TextEditingController(text: accountController.savedPassword.value);

    return Scaffold(
      body: Obx(
        () {
          if (accountController.isLoading.value) {
            // Display loading screen if isLoading is true
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Display the main sign-in form if not loading
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.0),
                  // Big logo at the top
                  Center(
                    child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/EngGate.png', width: 100, height: 100),
                    const SizedBox(width: 16),
                    Image.asset('assets/images/fieldReadyTurk.png', width: 100, height: 100),
                  ],
                ),
                  ),
                  const SizedBox(height: 40.0),
          
                  // Welcome text
                  Center(
                    child: Text(
                      'أهلا و سهلا',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
          
                  // Username input field
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: usernameController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'رقم الهاتف',
                        labelStyle: const TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                        ),
                        prefixIcon: const Icon(Icons.person),
                        alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 16.0),
          
                  // Password input field
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: passwordController,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'كلمة السر',
                        labelStyle: const TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        alignLabelWithHint: true,
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Remember Me checkbox
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('تذكرني'),
                        Obx(
                          () => Checkbox(
                            value: accountController.rememberMe.value,
                            onChanged: (bool? value) {
                              accountController.rememberMe.value = value ?? false;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
          
                  // Forgot password button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password logic here
                        Get.toNamed(Routes.forgotPasswordScreen);
                      },
                      child: Text(
                        'نسيت كلمة السر',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
          
                  // Sign In button
                  ElevatedButton(
                    onPressed: () {
                     accountController.signIn(usernameController.text, passwordController.text);
                    },
                    child: Text('تسجيل الدخول'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
          
                  // Sign Up button
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.registerScreen);
                        // Sign up logic here
                      },
                      child: Text(
                        'تسجيل',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

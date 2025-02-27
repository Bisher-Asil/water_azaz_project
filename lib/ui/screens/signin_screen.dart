import 'package:water_azaz_project/config/routes/routes.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: "test@test.tst");
    final TextEditingController passwordController =
        TextEditingController(text: "123456");
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Big logo at the top
              Center(
                child: Image.asset(
                  'assets/images/logo.png', // Replace with your logo asset path
                  height: 150.0,
                ),
              ),
              const SizedBox(height: 40.0),

              // Welcome text
              Center(
                child: Text(
                  'أهلا و سهلا',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Username input field
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'رقم التليفون',
                  prefixIcon: const Icon(Icons.person),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),

              // Password input field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelText: 'كلمة السر',
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10.0),

              // Remember Me checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {},
                  ),
                  Text('تذكرني'),
                ],
              ),
              const SizedBox(height: 10.0),

              // Forgot password button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'نسيت كلمة السر',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Sign In button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text('تسجيل الدخول'),
              ),
              const SizedBox(height: 16.0),

              // Sign Up button
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'تسجيل',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
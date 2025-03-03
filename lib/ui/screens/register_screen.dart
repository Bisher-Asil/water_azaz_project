import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';
import 'package:geolocator/geolocator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      _showLocationErrorDialog(context, 'Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        _showLocationErrorDialog(context, 'Location permissions are denied');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, don't continue
      _showLocationErrorDialog(context, 'Location permissions are permanently denied, we cannot request permissions.');
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue
    return await Geolocator.getCurrentPosition();
  }

  void _showLocationErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 10),
                      accountController.signInStatus.value ? Container(): TextFormField(
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
                      ) ,
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text('انا اقبل في التعليمات و الشروط'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              // Get the user's location
                              Position position = await _determinePosition(context);
                              var fullName = _NameController.text;
                              var phone = _phoneController.text;
                              var password = _passwordController.text;
                              var latitude = position.latitude;
                              var longitude = position.longitude;

                              // Send the registration information along with the location to the controller
                              accountController.registerUserRequest(fullName, phone, password, latitude, longitude);
                            } catch (e) {
                              // Handle the error if location permissions are denied
                              print(e);
                            }
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/logic/controllers/account_ctrl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      _showLocationErrorDialog(context, 'يرجى تفعيل خدمات الموقع');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        _showLocationErrorDialog(context, 'يرجى منح إذن الوصول إلى الموقع');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, don't continue
      _showLocationErrorDialog(context,
          'خدمات الموقع ممنوعة بشكل دائم, يرجى منح الإذن من إعدادات الجهاز');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue
    return await Geolocator.getCurrentPosition();
  }

  void _showLocationErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('اذون الموقع مطلوبة'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('حسنا'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AccountController accountController = Get.find();
    final _NameController = TextEditingController();
    final _phoneController = TextEditingController();
    final _passwordController = TextEditingController();
    final _securityQuestionController = TextEditingController();
    final _securityAnswerController = TextEditingController();
    final _addressController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Obx(() => Scaffold(
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/EngGate.png', // Replace with your logo asset path
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
                              decoration:
                                  InputDecoration(labelText: 'رقم الهاتف'),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى ادخال رقم الهاتف';
                                } else {
                                  if (value.length < 3) {
                                    return 'رقم الهاتف يجب أن يكون صحيح ';
                                  }
                                  if (value.length > 15) {
                                    return 'رقم الهاتف يجب أن يكون صحيح ';
                                  }
                                }
                                return null;
                              },
                              controller: _phoneController,
                            ),
                            const SizedBox(height: 10),
                            accountController.signInStatus.value
                                ? Container()
                                : TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'كلمة السر',
                                      helperText:
                                          "يجب أن تكون كلمة المرور 4 خانات على الأقل",
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
                                  ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "سؤال الأمان",
                                  helperText:
                                      "مثال: ما هو اسم مدرستك الإبتدائية؟ \nيستخدم سؤال الأمان في حال نسيان كلمة المرور"),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى ادخال سؤال الأمان';
                                }
                                return null;
                              },
                              controller: _securityQuestionController,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'جواب سؤال الأمان'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى ادخال جواب سؤال الأمان';
                                }
                                return null;
                              },
                              controller: _securityAnswerController,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'العنوان'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى ادخال العنوان';
                                }
                                return null;
                              },
                              controller: _addressController,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Checkbox(value: true, onChanged: (value) {}),
                                GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        'https://waterqualityazaz.com/TermsAndConditions');

                                    final bool launched = await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );

                                    if (!launched) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text(
                                    'انا اقبل في التعليمات و الشروط',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "ملاحظة: تشغيل خدمات الموقع مطلوب للتسجيل",
                              style: TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    // Get the user's location
                                    Position position =
                                        await _determinePosition(context);
                                    var fullName = _NameController.text;
                                    var phone = _phoneController.text;
                                    var password = _passwordController.text;
                                    var latitude = position.latitude;
                                    var longitude = position.longitude;
                                    var address = _addressController.text;
                                    var securityQuestion =
                                        _securityQuestionController.text;
                                    var securityAnswer =
                                        _securityAnswerController.text;

                                    // Send the registration information along with the location to the controller
                                    if (position.latitude == 0.0 &&
                                        position.longitude == 0.0) {
                                      Get.snackbar(
                                        'خطأ',
                                        'لم يتم تحديد الموقع بشكل صحيح. يرجى المحاولة مرة أخرى.',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      return;
                                    }
                                    accountController.registerUserRequest(
                                        fullName,
                                        phone,
                                        password,
                                        latitude,
                                        longitude,
                                        address,
                                        securityQuestion,
                                        securityAnswer);
                                  } catch (e) {
                                    // Handle the error if location permissions are denied
                                    print(e);
                                  }
                                }
                              },
                              child: Text(accountController.signInStatus.value
                                  ? "تأكيد التعديل"
                                  : 'تسجيل'),
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
          ),
        ));
  }
}

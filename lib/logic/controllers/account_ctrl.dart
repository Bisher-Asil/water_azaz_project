import 'dart:convert';

import 'package:get/get.dart';
import 'package:water_azaz_project/config/routes/routes.dart';
import 'package:water_azaz_project/services/auth_service.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  var isLoading = false.obs;
  var signInStatus = false.obs;
  final RxBool rememberMe = false.obs;
  var savedUsername = ''.obs;
  var savedPassword = ''.obs;

  var phoneNumber = ''.obs;


  final _storage = GetStorage();
  static const String REMEMBER_ME_KEY = 'remember_me';
  static const String USERNAME_KEY = 'username';
  static const String PASSWORD_KEY = 'password';

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() {
    bool? savedRememberMe = _storage.read(REMEMBER_ME_KEY);
    if (savedRememberMe == true) {
      rememberMe.value = true;
      savedUsername.value = _storage.read(USERNAME_KEY) ?? '';
      savedPassword.value = _storage.read(PASSWORD_KEY) ?? '';
    }
  }
  

  void signIn(String userName, String password) async {
    isLoading.value = true;
    try {
      final response = await _authService.login(userName, password);
      print('Login Response: $response'); // Debug log to inspect the response

      // Check if the token exists in the response
      if (response.containsKey('token') && response['token'] != null) {
        // Save credentials if remember me is checked
        if (rememberMe.value) {
          await _storage.write(USERNAME_KEY, userName);
          await _storage.write(PASSWORD_KEY, password);
          await _storage.write(REMEMBER_ME_KEY, true);
        } else {
          // Clear saved credentials if remember me is unchecked
          await _storage.remove(USERNAME_KEY);
          await _storage.remove(PASSWORD_KEY);
          await _storage.remove(REMEMBER_ME_KEY);
        }
        
        signInStatus.value = true;
        Get.put(_authService); // Store the AuthService instance in GetX
        
        Get.offAllNamed(Routes.feedbackScreen);
      } else {
        signInStatus.value = false;
        Get.snackbar("خطأ", "اسم المستخدم أو كلمة المرور غير صحيحة");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void passwordResetRequest(String email) async {
    
  }

  void registerUserRequest(String fullName, String phoneNumber, String password, double lat, double lng, String address, String securityQuestion, String securityAnswer) async {
   isLoading.value = true;
    try {

      bool success = await _authService.register(RegisterDto(phoneNumber: phoneNumber, fullName: fullName, securityQuestion: securityQuestion, securityQuestionAnswer: securityAnswer, address: address, locationLatitude: lat.toString(), locationLongitude: lng.toString(), password: password, confirmPassword: password));
      if (success) {
        Get.snackbar("نجحت العملية", "تم التسيجيل بنجاح");
        Get.offNamed(Routes.signInScreen);
      } else {
        Get.snackbar("خطأ", "فشلت العملية, يرجى التأكد من البيانات المدخلة");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void deleteUserRequest(String password) async {
  /*  isLoading.value = true;
    try {
      bool success = await _authService.deleteUser(password);
      if (success) {
        Get.snackbar("Success", "User deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete user");
      }
    } finally {
      isLoading.value = false;
    }*/
  }

  void getSecurityQuestion(String phoneNumber) async {
    this.phoneNumber.value = phoneNumber;
    isLoading.value = true;
    try {
      final response = await _authService.getSecurityQuestion(phoneNumber);
      if (response != null && response.isNotEmpty) {
        Get.toNamed(Routes.securityQuestionScreen, arguments: response);
      } else {
        Get.snackbar("خطأ", "حصل خطأ أثناء استرجاع السؤال الأمني, يرجى التأكد من رقم الهاتف");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void verifySecurityQuestion(String phoneNumber, String answer) async {
    isLoading.value = true;
    try {
      final response = await _authService.verifySecurityQuestion(SecurityQuestionDto(phoneNumber: phoneNumber, securityQuestionAnswer: answer));
      if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
        var resetPasswordCode = responseBody['passwordResetCode'];
        Get.toNamed(Routes.newPasswordScreen, arguments: resetPasswordCode);        } else  if (response.statusCode == 403) {          
        Get.snackbar("خطأ", "اجابة السؤال الأمني غير صحيحة, يرجى المحاولة مرة أخرى");
      } else {
        Get.snackbar("خطأ", "حصل خطأ أثناء التحقق من السؤال الأمني, يرجى المحاولة لاحقاً");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void resetPassword(String phoneNumber, String newPassword, String code) async {
    isLoading.value = true;
    try {
      final success = await _authService.resetPassword(ResetPasswordDto(phoneNumber: phoneNumber, newPassword: newPassword, code: code));
      if (success) {
        Get.snackbar("نجحت العملية", "تم تغيير كلمة السر بنجاح");
        Get.offAllNamed(Routes.signInScreen);
      } else {
        Get.snackbar("خطأ", "فشلت العملية, يرجى كتابة كلمة السر الجديدة بشكل صحيح");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
import 'package:get/get.dart';
import 'package:water_azaz_project/config/routes/routes.dart';
import 'package:water_azaz_project/services/auth_service.dart';

class AccountController extends GetxController {
  var isLoading = false.obs;
  var signInStatus = false.obs;
  final RxBool rememberMe = false.obs;

  final AuthService _authService = AuthService();

  void signIn(String userName, String password) async {
    isLoading.value = true;
    try {
      final response = await _authService.login(userName, password);
      print('Login Response: $response'); // Debug log to inspect the response

      // Check if the token exists in the response
      if (response.containsKey('token') && response['token'] != null) {
        signInStatus.value = true;
        Get.offAllNamed(Routes.feedbackScreen);
      } else {
        signInStatus.value = false;
        Get.snackbar("Error", "Invalid username or password");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxBool resetPasswordCodeStatus = false.obs;
  String resetPasswordUserEmail = "";
  String resetPasswordCode = "";

  void resetPasswordScreenEntered() {
    resetPasswordCodeStatus.value = false;
    resetPasswordUserEmail = "";
    resetPasswordCode = "";
  }

  void passwordResetRequest(String email) async {
    /*isLoading.value = true;
    try {
      bool success = await _authService.requestPasswordReset(email);
      if (success) {
        resetPasswordUserEmail = email;
        Get.snackbar("Success", "Password reset email sent");
      } else {
        Get.snackbar("Error", "Failed to send password reset email");
      }
    } finally {
      isLoading.value = false;
    }*/
  }

  void registerUserRequest(String fullName, String phone, String password, double lat, double lng, String address) async {
   isLoading.value = true;
    try {
      bool success = await _authService.register(fullName: fullName, phoneNumber: phone, password: password, locationLatitude: lat.toString(), locationLongitude: lng.toString(),address: address, confirmPassword: password);
      if (success) {
        Get.snackbar("Success", "User registered successfully");
        Get.offNamed(Routes.signInScreen);
      } else {
        Get.snackbar("Error", "Failed to register user");
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
}
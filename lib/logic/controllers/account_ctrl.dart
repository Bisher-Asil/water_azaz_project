import 'package:get/get.dart';

class AccountController extends GetxController {
  
  var isLoading = false.obs;

  var signInStatus = false.obs;
  final RxBool rememberMe = false.obs;

 void signIn(String userName, String password) async {
    
  }
RxBool resetPasswordCodeStatus = false.obs;
String resetPasswordUserEmail = "";
String resetPasswordCode = "";

void resetPasswordScreenEntered(){
  resetPasswordCodeStatus.value = false;
  resetPasswordUserEmail = "";
  resetPasswordCode = "";
}
  void passwordResetRequest(String email) async{
   
  }

  void registerUserRequest(String fullName, String phone, String password) async{
  }

   void deleteUserRequest(String password) async{

  }
}
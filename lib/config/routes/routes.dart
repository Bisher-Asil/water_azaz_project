import 'package:water_azaz_project/config/routes/unknown_route.dart';
import 'package:get/get.dart';
import 'package:water_azaz_project/ui/screens/forgot_password_screen.dart';
import 'package:water_azaz_project/ui/screens/register_screen.dart';
import 'package:water_azaz_project/ui/screens/signin_screen.dart';
import 'package:water_azaz_project/ui/screens/wow.dart';

class Routes {
  Routes._();

  static GetPage<dynamic> notFound = GetPage(
    name: '/notFound',
    page: () => const UnknownRoute(),
  );

  static List<GetPage<dynamic>> getPages = [
    GetPage(
        name: homeScreen,
        page: () => const CenteredTextScreen(),
        transition: Transition.noTransition),
      GetPage(
        name: signInScreen,
        page: () => const SignInScreen(),
        transition: Transition.noTransition),
        GetPage(
        name: registerScreen,
        page: () => const RegisterScreen(),
        transition: Transition.noTransition),
        GetPage(
        name: forgotPasswordScreen,
        page: () => const ForgotPasswordScreen(),
        transition: Transition.noTransition),
  ];
   static String homeScreen = "/";
   static String signInScreen = "/signInScreen";
   static String registerScreen = "/registerScreen";
   static String forgotPasswordScreen = "/forgotPasswordScreen";

  
}

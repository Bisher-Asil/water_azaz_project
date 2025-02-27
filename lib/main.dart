import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:water_azaz_project/config/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'config/routes/routes.dart';
import 'logic/bindings/main_binding.dart';

void main() async {
  await preInitializations();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => AdaptiveTheme(
        initial: AdaptiveThemeMode.light,
        light: CustomAppTheme.instance.lightThemeData(),
        dark: CustomAppTheme.instance.darkThemeData(),
        builder: (light, darkTheme) => GetMaterialApp(
          theme: light,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          title: 'Water',
          initialRoute: Routes.signInScreen,//'/',
          unknownRoute: Routes.notFound,
          getPages: Routes.getPages,
          initialBinding: MainBinding(),
          //home: const SignInScreen(),
        ),
      ),
    );
  }
}

Future preInitializations() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
 
}
